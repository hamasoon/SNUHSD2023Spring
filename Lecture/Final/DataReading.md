<!-- vscode-markdown-toc -->
* 1. [IOMMU](#IOMMU)
		* 1.1. [Overview](#Overview)
		* 1.2. [Utilization](#Utilization)
		* 1.3. [Hierarchical page table](#Hierarchicalpagetable)
* 2. [Interconnector](#Interconnector)
		* 2.1. [Split Transaction](#SplitTransaction)
		* 2.2. [Narrow and Wide Transfer](#NarrowandWideTransfer)
		* 2.3. [Burst](#Burst)
		* 2.4. [Handshacking](#Handshacking)
		* 2.5. [Deadlock in Valid/Ready Signal](#DeadlockinValidReadySignal)
		* 2.6. [Outstanding Request (Very Important)](#OutstandingRequestVeryImportant)
		* 2.7. [Aribitation](#Aribitation)
* 3. [DRAM](#DRAM)
		* 3.1. [DRAM architecture](#DRAMarchitecture)
		* 3.2. [Scheduling](#Scheduling)
		* 3.3. [Refresh](#Refresh)
		* 3.4. [Row Hammer](#RowHammer)
		* 3.5. [Error Correction Code](#ErrorCorrectionCode)

<!-- vscode-markdown-toc-config
	numbering=true
	autoSave=true
	/vscode-markdown-toc-config -->
<!-- /vscode-markdown-toc --># Reading Data from Memory

##  1. <a name='IOMMU'></a>IOMMU
- Memory address translator

####  1.1. <a name='Overview'></a>Overview
- Each hardware request data with it's logical address
    - Then MMU translate this address to physical address(in main memory?)
    - first, check TLB inside MMU    
        - hit : get address directly
        - miss : access to page table inside main memory and get address
    - Using address, get data

####  1.2. <a name='Utilization'></a>Utilization
- Solution of memory fragment problem
    - fragment cause large contiguous memory resource hard to find
    - by using mapping table, we can get data from main memory without full scanning

- Another problem of fragment
    - Without mapping table, we have to devide memory for each type of data(or purpose)
        - We call this seperation as contiguous region of physical address
    - in this case, when we doesn't use kind of data type, then waste that region of physical memory
    - IOMMU provide demand paging

####  1.3. <a name='Hierarchicalpagetable'></a>Hierarchical page table
- As with most of computer memory, page table also contruct hierarchically

- e.g. virtual address
    |  31-22 |  21-12 | 11-0 |
    |--------|--------|------|
    |L1 index|L2 index|Offset| 
    - First, look at Level-1 page table
    - Second, look at Level-2 page table &rarr; get physical address of data
    - Access to physical address and get data
    
- So, without cache, translate time = memory access time $\times$ Level of page table

##  2. <a name='Interconnector'></a>Interconnector
- Connecting memory and device and provide interface between those device

####  2.1. <a name='SplitTransaction'></a>Split Transaction 
- Split address, data, signal, response channel and handle those transaction seperately

####  2.2. <a name='NarrowandWideTransfer'></a>Narrow and Wide Transfer
- We can transfer data widely also, narrowly
    - by using narrow transfer, we can provide small data type like float16

####  2.3. <a name='Burst'></a>Burst
- Request 0, 4, 8, 12, 16, 20, 24, 28, 32, 36 is actually same as 10 4byte data from 0

####  2.4. <a name='Handshacking'></a>Handshacking
- Both valid and readt signal is on, then start transfer

####  2.5. <a name='DeadlockinValidReadySignal'></a>Deadlock in Valid/Ready Signal
- valid signal should not depends on ready!!!!!
- those two signal must be independent from each other

- Only read data from two signal become valid simultaneously

####  2.6. <a name='OutstandingRequestVeryImportant'></a>Outstanding Request (Very Important)
- The capability of multiple outstanding requests is to allow multiple requests to be issued previous requests completed.

- To reduce penalty of cache miss, We generally using Non-blocking cache
    - **Non-Blocking Cache** : Cache that doesn't waiting eventhough cache miss occur

- Benefit
    - Accept new request and send data concurrently
    - access multiple DRAM banks in parallel thereby realizing maximum DRAM bandwidth

####  2.7. <a name='Aribitation'></a>Aribitation
- Fixed Priority : High priority first always

- Round-Robin : fairly

- Fair Arbitration : Grouped Priority Round-Robin
    - Grouping master with priority and run round-robin for each group

##  3. <a name='DRAM'></a>DRAM

####  3.1. <a name='DRAMarchitecture'></a>DRAM architecture
- Multiple **banks**
    - **Rows** under banks : access to row using **Row address decoder**
        - get all data inside rows to **row buffer**
        - **Cells** under rows
            - get wanted data by using **column decode**

- Handling overlapped miss request
    - Case 1 : Target data under multiple banks (Bank Parallelism)
    - Case 2 : Target data under same rows (Row buffer hits)

- DRAM Operation
    - Sequence
        1. Pre Charging(could be last process)
            - Precharging BL capacitor as half 
        2. Charge Sharing
            - if 1, BL capacity increase slightly due to migrate voltage from cell
            - else BL capcitor voltage deceased due to voltage migrate to cell
        3. Thresholding
            - Using sense amplifier to detect BL capcitor's voltage
            - send BL line to 1 or 0
        4. Restoring
            - if 1, Cell and BL capcitor recharge due to BL is 1
            - else, Cell and BL capcitor empty due to BL is 0 then discharging it
        5. Return Pre-charge phase

    - Timing
        1. tRCD : charge sharing to thresholding
        2. tRAS : charge sharing to restoring = activation timing
        3. tRP : precharing delay
        4. tRC : total delay

        - Normally calculate as 3 dimension(3 cycle)
            - ACT &rarr; RD/WR &rarr; PRE(with data transfer to processor : D)

    - Version
        - SDRAM : Single-edge DRAM
        - DDR : Double-edge DRAM
        - DDR2 : faster DDR - increase clock speed
        - DDR3 : more faster DDR - increase clock speed more

####  3.2. <a name='Scheduling'></a>Scheduling
- Assumption : ACT/RD/PRE - 3 cycle, D - 2 cycle
0. Normal case
    - single read total cycle : $3 + 3 + 3$
    - data transfer cycle : $2$
    - utilization : $2/9 = 22.2\%$

1. Row Buffer Hits
    - If target address locate in same row, we can skip ACT, PRE and concurrently execute D and RD
    - guess n data in single row
        - one activation and one Pre + N precharge : $3 + 3 + 3 + 2 \times (n-1)$ &rarr; reduce RD time by concurrent running
        - data transfer cycle : $2 \times n$
        - utilization : $ (2\times n) / (9 + 2\times(n-1))$
            - if 2 data, $4/11 = 36.4\%$ 

2. Bank Parallelism
    - If data locate in different bank, then we can parallelly execute reading
    - In this case, for seperate data transfer, each single operation must be scheduled to avoid simultaneous transfer process

- Data Storing Strategy
    - For larger data, actually Row buffer hits could be more efficient parallelism
    - So, place highly correlatd hot variable on the same DRAM row is very important

####  3.3. <a name='Refresh'></a>Refresh
- Overhead
    - Power
    - Latency

- Latency Solution 1 : Adjust timing
    - Postponing or pulling to avoid refresh during needed 
    - 

- Power Solution : PASR, fine-grained self refresh
    - PASR
    - fine-grained self refresh

####  3.4. <a name='RowHammer'></a>Row Hammer
- Yes it is problem but...
    - it think it's not important...

- Solution
    - Naive

    - PARA

####  3.5. <a name='ErrorCorrectionCode'></a>Error Correction Code
- Calculation... : I will see this in later