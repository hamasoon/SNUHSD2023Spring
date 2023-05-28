# Optimization : Pruning

<!-- vscode-markdown-toc -->
* 1. [Simple Pruning](#SimplePruning)
		* 1.1. [How to store sparse matrix?](#Howtostoresparsematrix)
		* 1.2. [Weight Clustering](#WeightClustering)
* 2. [Structured Pruning](#StructuredPruning)
		* 2.1. [Groupwise brain damage](#Groupwisebraindamage)
		* 2.2. [Nvidia 2:4 rule pruning](#Nvidia2:4rulepruning)
* 3. [Rottery Ticket prunning](#RotteryTicketprunning)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc -->

##  1. <a name='SimplePruning'></a>Simple Pruning
- Zero-skipping : make small value weight as 0
####  1.1. <a name='Howtostoresparsematrix'></a>How to store sparse matrix?
- Using three list
  - Row pointer : Indicate boundary of column and value list
    - ex) C[i] = 9, C[i] = 12 -> column indices, and values 9 to 11 value is data of ith row
  - Colunmn indices : column indices of that row
  - value : value of that column index
  - ex)
    | List Name      | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
    | -------------- | --- | --- | --- | --- | --- | --- | --- | --- |
    | Row pointer    | 0   | 2   | 4   | 6   | 7   | 10  | 13  |     |
    | Column indices | 2   | 3   | 0   | 1   | 2   | 4   | 3   | ... |
    | Values         | A   | B   | C   | D   | E   | F   | G   | H   |
    - M[0][2] == A, M[2][2] == E

####  1.2. <a name='WeightClustering'></a>Weight Clustering
- Clustering weights descretly, and training does clustered weight
  - Group by each clustered block's gradient and reduce them to single value

##  2. <a name='StructuredPruning'></a>Structured Pruning

####  2.1. <a name='Groupwisebraindamage'></a>Groupwise brain damage
- Simple Idea : do not spend cycle on calculate zero-column input

####  2.2. <a name='Nvidia2:4rulepruning'></a>Nvidia 2:4 rule pruning
- Only maintaining half of weight : set 2 zero for 0 in 4 weights
  - Select lowest 2 weight in 4 data : But it is not efficient &rarr; we want to delete almost lowest data
  - So, reallocate weight matrix row to efficiently delete lowest weight
- Then compress prunned weight matrix with **meta data**
  - meta data is 2b indices to indicate original data's location
  - if) 0, 2 data deleted and 1, 3 left &rarr; then meta data is 01(1), 11(3)

##  3. <a name='RotteryTicketprunning'></a>Rottery Ticket prunning
1. Training like traditionally(init &rarr; train &rarr; prune)
2. Restart but in this time, pruning first with the result of previous train
   - Pruning with the sub-network of previous trained result
   - Note that init prameters should be same as always