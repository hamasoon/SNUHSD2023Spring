# Precision
- Reduction in memory cost
- Reduction in computation cost

## Floating Point with 8 Bytes

#### Representation : E4M3
- Normal : Non-zero E
  - $(-1)^s \times (1.0 + 0.M) \times 2^{E-bias}$
  - bias = 7
- Subnormal : Zero E
  - $(-1)^s \times (0.0 + 0.M) \times 2^{-6}$

#### QAT(Quantization-Aware Training)
1. Train network in full precision(fp16)
2. Quantize FP weight and execute model
3. Back-propagate the error (using quantized weights/activations and full-precision gradient) and update the FP weights

#### Quantization
1. Calculating Scale(S-value) and Zero(Z-value)
  - $S = (MAX-MIN)/255$ 
  - $Z = round(MIN/S)$
2. Original to Quantization(Original real)
  - $q = round(x/S) + Z$
3. Quantization to Original(Fake real)
  - $R' = S(q - Z)$

## Clipping
- Clipping : truncate range of weight(ignore too large, too small value for ideal quantization)

#### PACT(Parameterized Clipping Activation Function)
- Basically, automatically training clipping threshold 
1. Replace ReLU function with bounded-ReLU
  - 
2. s
3. 

#### LSQ(Learned Step size Quantization)
- Train scale gap of quantization