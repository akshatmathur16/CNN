//Author: Akshat Mathur
//Code revisions:

module convolution #(parameter IP_DATA_WIDTH=8, IFMAP_SIZE=5, FILTER_SIZE=3, STRIDE=1, OFMAP_SIZE=(IFMAP_SIZE-FILTER_SIZE)/STRIDE+ 1, ARRAY_WIDTH=3, POOL_FILTER_SIZE = 2, POOL_STRIDE = 1, RESULT_WIDTH = ((ARRAY_WIDTH-POOL_FILTER_SIZE)/POOL_STRIDE) + 1) 

(
    input bit [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0],
    input bit [IP_DATA_WIDTH-1:0] filter [FILTER_SIZE-1:0][FILTER_SIZE-1:0],
    output bit [(2*IP_DATA_WIDTH)-1:0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0]

);


 
generate

bit [(2*IP_DATA_WIDTH)-1:0] temp_reg[OFMAP_SIZE*OFMAP_SIZE] [FILTER_SIZE*FILTER_SIZE-1:0];

for(genvar i=0; i<OFMAP_SIZE*OFMAP_SIZE; i++)
begin

    for(genvar j=0; j <FILTER_SIZE; j++)
    begin

        for(genvar k=0; k<FILTER_SIZE; k++)
        begin

            assign temp_reg[i][FILTER_SIZE*FILTER_SIZE - (k+j*FILTER_SIZE) -1] = ifmap[j + (i/OFMAP_SIZE)*STRIDE][k + (i%OFMAP_SIZE)*STRIDE] * filter[j][k];
        end
    end
  end

endgenerate


conv_mac #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .IFMAP_SIZE(IFMAP_SIZE), .FILTER_SIZE(FILTER_SIZE), .STRIDE(STRIDE), .OFMAP_SIZE(OFMAP_SIZE), .ARRAY_WIDTH(ARRAY_WIDTH), .POOL_STRIDE(POOL_STRIDE), .RESULT_WIDTH(RESULT_WIDTH)) inst_conv_mac 
(
    //.clk(clk),
    .matrix(temp_reg), 
    .result_matrix(result_matrix)
);


endmodule
