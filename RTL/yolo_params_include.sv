//convolution
parameter IP_DATA_WIDTH=8;
parameter WT_WIDTH=8;
parameter IFMAP_SIZE=5;
parameter FILTER_SIZE=3;
parameter STRIDE=1;
parameter OFMAP_SIZE=(IFMAP_SIZE-FILTER_SIZE)/STRIDE+ 1;
//max pooling parameters
parameter ARRAY_WIDTH=3;
parameter POOL_FILTER_SIZE = 2;
parameter POOL_STRIDE = 1;
parameter RESULT_WIDTH = ((ARRAY_WIDTH-POOL_FILTER_SIZE)/POOL_STRIDE) + 1;
