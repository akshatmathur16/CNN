//Author: Akshat Mathur
//Code revisions:

module convolution 
import yolo_params_pkg::*;
(
    input bit [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0],
    input bit [IP_DATA_WIDTH-1:0] filter [FILTER_SIZE-1:0][FILTER_SIZE-1:0],
    output bit [(2*IP_DATA_WIDTH):0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0]

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


conv_mac inst_conv_mac 
(
    .clk(clk),
    .matrix(temp_reg), 
    .result_matrix(result_matrix)
);


endmodule
