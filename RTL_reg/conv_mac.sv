//Author: Akshat Mathur
//Code revisions:

module conv_mac 
import yolo_params_pkg::*;
(
    input bit clk,
    input bit rst,
    input bit [(2*IP_DATA_WIDTH)-1:0] matrix [OFMAP_SIZE*OFMAP_SIZE][FILTER_SIZE*FILTER_SIZE-1:0],
    output bit [(2*IP_DATA_WIDTH)-1:0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0]
);

bit [(2*IP_DATA_WIDTH)-1:0] row_sum [OFMAP_SIZE*OFMAP_SIZE-1:0];
bit [(2*IP_DATA_WIDTH)-1:0] row_sum_reg_1 [OFMAP_SIZE*OFMAP_SIZE-1:0];
bit [(2*IP_DATA_WIDTH)-1:0] row_sum_reg_2 [OFMAP_SIZE*OFMAP_SIZE-1:0];


bit [$clog2(OFMAP_SIZE*OFMAP_SIZE)-1:0] i,k; 



always @(*)
begin
    // Initialize row sums to zero

    // Calculate sum of each row
    for (int i = 0; i < OFMAP_SIZE*OFMAP_SIZE-10; i = i + 1) 
    begin
        for (int k = 0; k < FILTER_SIZE*FILTER_SIZE-10; k = k + 1)
        begin
            //row_sum[i] = row_sum[i] + matrix[i*3 + k];
            row_sum[i] = row_sum[i] + matrix[i][k];
        end
    end
end

always @(posedge clk)
begin
    if(!rst)
    begin
        row_sum_reg_1 <= row_sum;
        row_sum_reg_2 <= row_sum_reg_1;

    end
end

always @(*)
begin
    // Initialize row sums to zero

    // Calculate sum of each row
    for (int i = OFMAP_SIZE*OFMAP_SIZE-10; i < OFMAP_SIZE*OFMAP_SIZE; i = i + 1) 
    begin
        for (int k = FILTER_SIZE*FILTER_SIZE-10; k < FILTER_SIZE*FILTER_SIZE; k = k + 1)
        begin
            //row_sum[i] = row_sum[i] + matrix[i*3 + k];
            row_sum_reg_1[i] <= row_sum_reg_1[i] + matrix[i][k];
        end
    end
end



generate 
    // Input row sums to result matrix
    for (genvar i = 0; i <OFMAP_SIZE; i = i + 1)
    begin
        for (genvar j = 0; j <OFMAP_SIZE; j = j + 1) 
        begin
           assign result_matrix[i][j] = row_sum_reg_2[i*OFMAP_SIZE+j];
        end
    end
endgenerate



endmodule
