module tb_convolution();

import yolo_params_pkg::*;

bit clk;
bit rst;
bit [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0];
bit [IP_DATA_WIDTH-1:0] filter[FILTER_SIZE-1:0][FILTER_SIZE-1:0];
bit [(2*IP_DATA_WIDTH):0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0];



convolution inst_convolution 
(
    .ifmap(ifmap),
    .filter(filter),
    .result_matrix(result_matrix)
);


initial begin
    #4; rst=0;
    ifmap[0][0] ='d1; 
    ifmap[0][1] ='d2;
    ifmap[0][2] ='d3; 
    ifmap[0][3] ='d4; 
    ifmap[0][4] ='d5; 
    ifmap[1][0] ='d6; 
    ifmap[1][1] ='d7; 
    ifmap[1][2] ='d8; 
    ifmap[1][3] ='d9; 
    ifmap[1][4] ='d10; 
    ifmap[2][0] ='d11; 
    ifmap[2][1] ='d12; 
    ifmap[2][2] ='d13; 
    ifmap[2][3] ='d14; 
    ifmap[2][4] ='d15; 
    ifmap[3][0] ='d16; 
    ifmap[3][1] ='d17; 
    ifmap[3][2] ='d18; 
    ifmap[3][3] ='d19;
    ifmap[3][4] ='d20; 
    ifmap[4][0] ='d21; 
    ifmap[4][1] ='d22; 
    ifmap[4][2] ='d23; 
    ifmap[4][3] ='d24; 
    ifmap[4][4] ='d25; 

    filter[0][0]='d2;
    filter[0][1]='d2;
    filter[0][2]='d2;
    filter[1][0]='d2;
    filter[1][1]='d2;
    filter[1][2]='d2;
    filter[2][0]='d2;
    filter[2][1]='d2;
    filter[2][2]='d2;


end

initial begin
    $monitor($time, "ifmap=%p, filter=%p", ifmap, filter);


    #100 $stop;
end




endmodule
