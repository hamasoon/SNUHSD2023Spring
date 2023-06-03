<!-- vscode-markdown-toc -->
* 1. [Floating Point with 8 Bytes](#FloatingPointwith8Bytes)
		* 1.1. [Representation : E4M3](#Representation:E4M3)
		* 1.2. [QAT(Quantization-Aware Training)](#QATQuantization-AwareTraining)
		* 1.3. [Quantization](#Quantization)
		* 1.4. [STE(Stright Through Estimator)](#STEStrightThroughEstimator)
* 2. [Clipping](#Clipping)
		* 2.1. [PACT(Parameterized Clipping Activation Function)](#PACTParameterizedClippingActivationFunction)
		* 2.2. [LSQ(Learned Step size Quantization)](#LSQLearnedStepsizeQuantization)
		* 2.3. [DiffQ(Differentiable Quantization)](#DiffQDifferentiableQuantization)
		* 2.4. [Binary Weight Network](#BinaryWeightNetwork)
		* 2.5. [XNOR-Net](#XNOR-Net)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc --># Precision
- Reduction in memory cost
- Reduction in computation cost

##  1. <a name='FloatingPointwith8Bytes'></a>Floating Point with 8 Bytes

####  1.1. <a name='Representation:E4M3'></a>Representation : E4M3
- Normal : Non-zero E
  - $(-1)^s \times (1.0 + 0.M) \times 2^{E-bias}$
  - bias = 7
- Subnormal : Zero E
  - $(-1)^s \times (0.0 + 0.M) \times 2^{-6}$

####  1.2. <a name='QATQuantization-AwareTraining'></a>QAT(Quantization-Aware Training)
1. Train network in full precision(fp16)
2. Quantize FP weight and execute model
3. Back-propagate the error (using quantized weights/activations and full-precision gradient) and update the FP weights

####  1.3. <a name='Quantization'></a>Quantization
1. Calculating Scale(S-value) and Zero(Z-value)
  - $S = (MAX-MIN)/255$ 
  - $Z = round(MIN/S)$
2. Original to Quantization(Original real)
  - $q = round(x/S) + Z$
3. Quantization to Original(Fake real)
  - $R' = S(q - Z)$

####  1.4. <a name='STEStrightThroughEstimator'></a>STE(Stright Through Estimator)
- Quantization is not differentiable
  - STE solve this problem by estimator function
  - identifty function : function that well approximates the quantization function and is differentiable
  - so, differentiating the estimator function rather than the quantization function

##  2. <a name='Clipping'></a>Clipping
- Clipping : truncate range of weight(ignore too large, too small value for ideal quantization)

####  2.1. <a name='PACTParameterizedClippingActivationFunction'></a>PACT(Parameterized Clipping Activation Function)
- Basically, automatically training clipping threshold 
1. Replace ReLU function with bounded-ReLU
  - $ y = 0.5(x + |x - \alpha| + \alpha)$ : PACT function
  - $\alpha$ : learnable parameter
2. Using PACT function, train network
  - Quantized activation : $Q(x) = round(y \cdot \frac{2^k-1}{\alpha}) \cdot \frac{\alpha}{2^k-1}$
  - In STE...
    - $\frac{\partial y_q}{\partial \alpha} = \frac{\partial y_q}{\partial y} \cdot \frac{\partial y}{\partial \alpha}$
    - in this case, $\frac{\partial y_q}{\partial y} = 1$
      - due to basically ReLU function
3. Update $\alpha$ by gradient descent
  - $\frac{\partial L}{\partial \alpha} = \frac{\partial L}{\partial y} \cdot \frac{\partial y}{\partial \alpha} + \lambda |\alpha|$

####  2.2. <a name='LSQLearnedStepsizeQuantization'></a>LSQ(Learned Step size Quantization)
- Train scale gap of quantization

####  2.3. <a name='DiffQDifferentiableQuantization'></a>DiffQ(Differentiable Quantization)
- Train # of bits of quantization
  - $Q(x, B) = x + \frac{\Delta}{2} \cdot u[-1, 1]$
  - $\Delta = \frac{max(x) - min(x)}{2^B - 1}$
  - $\frac{\partial Q}{\partial B} = \frac{\partial Q}{\partial \Delta} \cdot \frac{\partial \Delta}{\partial B}$

####  2.4. <a name='BinaryWeightNetwork'></a>Binary Weight Network
- Binary Weight Network : weight is binary
  - $W = B \cdot \alpha$
  - $B = sign(W)$ : binary weight
  - $\alpha = \frac{W^T sign(W)}{n} = \frac{1}{n} ||W||_1$ : scaling factor

####  2.5. <a name='XNOR-Net'></a>XNOR-Net
- XNOR-Net : weight and activation are binary
  - Binary multiplication + Binary accumulation + Binary activation &rarr; XNOR Operation + bit counts + take sign
