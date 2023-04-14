Convolutional Neural Network
============================
Convolution: 3D Input Case
--------------------------
1. Simple CNN
- Matrix size
  - input : H * H * C(channel - usually 4(rgba))
  - Filter : R * R * C
  - Output : E * E &rarr; $E = H - R$
- Total # multiplications / output feature map = **R \* R \* C \* E \* E**

2. Multi-Filter CNN
- Matrix size
  - input : H * H * C
  - Filter : R * R * C * M(# of filter)
  - Output : E * E * M &rarr; M filter create M output
- Total # multiplications / output feature map = **R \* R \* C \* M \* E \* E**
  
cf) output size
- stride, padding, kernel size is related
- $O = (I + 2*P - K)/S + 1$
  
Convolution Example : Alex Net
-------------------
1. 227 * 227 * 3 &rarr; 55 * 55 * 48, stride = 4. 
  - caculate parameter #
    - $(227 - K) / 4 + 1 = 55, 227 - K = 216, K = 11$
    - So, 11 * 11 * 3 is single filter
    - and in this case, 48 output is created so
    - parameter # = 11 * 11 * 3 * 48
  - multiplcation #
    - 11 * 11 * 3 * 48 * 55 * 55
2. 13 * 13 * 198 &rarr; 13 * 13 * 128, padding = 1
  - caculate parameter #
    - $(13 + 1*2 - K) + 1 = 13,  K = 3$
    - So, 3 * 3 * 198 is single filter
    - and in this case, 128 output is created so
    - parameter # = 3 * 3 * 198 * 128
  - multiplcation #
    - 3 * 3 * 198 * 128 * 13 * 13

Convolution with Matrix Multiplication (called Convolution Lowering)
--------------------------------------------------------------------
- Input matrixes to matrix
  - Each filtered area of matrixes to vector
  - Each vector length : R * R * C
  - Total vector # is output size's square : (H + 2*P - K) / S + 1 = E
  - So, (R * R * C) X (E * E) matrix generated
- Filter matrixes to matrix
  - Make single filter(R * R * C) as single vector
  - So, M X (R * R * C) matrix is generated
- then these two matrix multiply -> M X (E*E) matrix
  - convert single horizontal vector to output matrix

Tiling
------
- Divide input data as block
  - so, reconstruct output with block level matrix multiplcation output

Tensor Core
-----------
- Tensor core cancalculate 4x4 matrix in 1 cycle
  - using 16 pe for calculate for single vector dot product
    - provide row, column to data at once
  - So, for matrix computation, we have to using 4 outer product engine
  - and link each point of product engine with adder tree

Natural Language Process
========================
RNN
===
Transfomer
==========
BERT
====
1. Sturcture of Feed Forward Layer
  - 2 * fully connected layer + activation function
  - $[L \times H] \times [H \times 4H]$ &rarr; $[L \times 4H]$ &rarr; $[L \times 4H] \times [4H \times H]$ &rarr; $[L \times H]$

Input and Output Size of BERT Layer
-----------------------------------
1. parameters
  - header # of multi-head model : h
  - dimension of hidden layer : d
  - sentence's word # : L
  - dimension of word vector : H
    - normally set H = h*d
  - dimension of feed forward layer : 4H (noramlly)

2. Size of model parameters
- size of matrix
- Input Size : $I = L \times H$
- Transfomer Weights : $W_{Q,K,V} = H \times d$
- Single Head Output : $O_s = [L\times H] \times [H \times d] = L \times d$
- Total Ouput = $O_m = L \times (d \times h) = L \times H$
- Header Selection Weight $H \times H$
- Feed Forward Layer Parmeters #
  - 1st Layer : $[H \times 4H]$
  - 2nd Layer : $[4H \times H]$
- ***Total Model Size : $12H^2$***
  - Input : $LH$
  - Multi-Head Attention : $ 4H^2$
  - Feed Forward Layer : $8H^2$

3. Multiplication #
- Multi-Head attention
  - Weight Multiplcation
    - $4 \times [L \times H] \times [[H \times d] \times h] = [4 \times L \times H \times d \times h] = 4LHhd = 4 LH^2$
  - Output Selection
    - $[L \times H] \times [H \times H] = LH^2$
- Feed Forward
  - $[L \times H] \times [H \times 4H] = 4LH^2$
  - $[L \times 4H] \times [4H \times H] = 4LH^2$
- ***Total = $4LH^2 + LH^2 + 8LH^2 = 13 Lh^2 \approx 52L^3 $***

Data Parallelism
================

Distribute Storage Model
------------------------
- Data Parallel
  - save each model in single GPU : run model in single GPU
  - All Reduce parameter (12H^2)
  - but GPU memory is too small to save all weight data of model
    - Also, model data need more memory due to some training weight...

- Model Parallel
  - store model parameter distributly
  - All Gather input (2L^2)
  - bit normally, input data size is much bigger than weight size

- Pipeline Model
  - Divide Layer of model
  - each GPU allocated to compute difference layer

Back Propagation and Memory Lack
--------------------------------
- Normally we use adam as gradient function
  - adam need 2 more parameter so,
  - ***per 1 parameter, we need 3 times memory***
- Acutal calculatioin for parameter # N,
  - fp16 copy of two parameter
  - fp32 copy of parameter, momentum, variance
  - total 16N bytes needed

ZeRO(Zero Redundancy Optimizer)
===============================

ZeRO-DP
-------
- Basically Data Parallel but, distributly save parameter to each GPU!
  - share parameters at that time(for single layer)

ZeRO-Offload
------------
- Run Adams code in CPU!
  - optimizer's parameter(2*N parameters) in CPU
  - GPU needed less memory

ZeRO-infinity
-------------
- Using NVME, CPU Flash memory to store parameter
- loading parameter when they needed