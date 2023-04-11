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
- Data Size of CNN : 2nd convolutional layer

Tensor Core
-----------