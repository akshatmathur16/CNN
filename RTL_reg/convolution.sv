//Author: Akshat Mathur
//Code revisions:

(* keep_hierarchy = "yes" *)module convolution 
import yolo_params_pkg::*;
(
    input clk,
    input rst,
    input bit [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0],
    input bit [IP_DATA_WIDTH-1:0] filter [FILTER_SIZE-1:0][FILTER_SIZE-1:0],
    output bit [(2*IP_DATA_WIDTH)-1:0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0]

);

bit [IP_DATA_WIDTH-1:0] ifmap_reg[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0];
bit [IP_DATA_WIDTH-1:0] filter_reg [FILTER_SIZE-1:0][FILTER_SIZE-1:0];
bit [(2*IP_DATA_WIDTH)-1:0] result_matrix_wire [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0];


//TODO put reg on input output and temp_reg
//TODO update temp_reg assign to always block

bit [(2*IP_DATA_WIDTH)-1:0] temp_reg[OFMAP_SIZE*OFMAP_SIZE] [FILTER_SIZE*FILTER_SIZE-1:0];
bit [(2*IP_DATA_WIDTH)-1:0] temp_reg_reg[OFMAP_SIZE*OFMAP_SIZE] [FILTER_SIZE*FILTER_SIZE-1:0];

always @(posedge clk)
begin
    if(rst)
    begin
        for(int i=0; i< IFMAP_SIZE; i++)
        begin
            for(int j=0; j< IFMAP_SIZE; j++)
            begin
                ifmap_reg[i][j] <= 'b0;
            end
        end
        for(int i=0; i< FILTER_SIZE; i++)
        begin
            for(int j=0; j< FILTER_SIZE; j++)
            begin
                filter_reg[i][j] <= 'b0;
            end
        end
        for(int i=0; i< OFMAP_SIZE* OFMAP_SIZE; i++)
        begin
            for(int j=0; j< FILTER_SIZE*FILTER_SIZE; j++)
            begin
                temp_reg_reg[i][j] <= 'b0;
            end
        end

    end
    else
    begin
        ifmap_reg <= ifmap;
        filter_reg <= filter;
        temp_reg_reg <= temp_reg;
    end
end
 
generate



for(genvar i=0; i<OFMAP_SIZE*OFMAP_SIZE; i++)
begin
    for(genvar j=0; j <FILTER_SIZE; j++)
    begin
        for(genvar k=0; k<FILTER_SIZE; k++)
        begin
            assign temp_reg[i][FILTER_SIZE*FILTER_SIZE - (k+j*FILTER_SIZE) -1] = ifmap_reg[j + (i/OFMAP_SIZE)*STRIDE][k + (i%OFMAP_SIZE)*STRIDE] * filter_reg[j][k];
        end

    end
end

endgenerate




(* keep_hierarchy = "yes" *)conv_mac inst_conv_mac 
(
    .clk(clk),
    .matrix(temp_reg_reg), 
    .result_matrix(result_matrix_wire)
);

always @(posedge clk)
begin
    if(rst)
    begin
        for(int i=0; i< FILTER_SIZE; i++)
        begin
            for(int j=0; j< FILTER_SIZE; j++)
            begin
                result_matrix[i][j] <= 'b0;
            end
        end
    end
    else
    begin
        result_matrix <= result_matrix_wire;
    end
end


endmodule
