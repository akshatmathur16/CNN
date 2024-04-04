package yolo_params_pkg;
    
parameter IP_DATA_WIDTH=7;
parameter IFMAP_SIZE=5;
parameter FILTER_SIZE=3;
parameter STRIDE=1;
parameter OFMAP_SIZE=(IFMAP_SIZE-FILTER_SIZE)/STRIDE+ 1;
//max pooling parameters
parameter ARRAY_WIDTH=4;
parameter POOL_FILTER_SIZE = 2;
parameter POOL_STRIDE = 2;
parameter RESULT_WIDTH = ((ARRAY_WIDTH-POOL_FILTER_SIZE)/POOL_STRIDE) + 1;

//full connected layer

parameter IP_LAYER_NEURONS=3;
parameter ACT_FN="SIGMOID";
parameter IP_DATA_WIDTH=8;
parameter NUM_IP=8;
parameter ACT_FN_SIZE=5;
parameter DENSE_LAYER=1;
parameter DENSE_LAYER_NEURONS=2;

endpackage
