//Author: Akshat Mathur
//Code revisions:

module conv_mac #(parameter IP_DATA_WIDTH=8, IFMAP_SIZE=5, FILTER_SIZE=3, STRIDE=1, OFMAP_SIZE=(IFMAP_SIZE-FILTER_SIZE)/STRIDE+ 1, ARRAY_WIDTH=3, POOL_FILTER_SIZE = 2, POOL_STRIDE = 1, RESULT_WIDTH = ((ARRAY_WIDTH-POOL_FILTER_SIZE)/POOL_STRIDE) + 1) 
(
    //input bit clk,
    input bit [(2*IP_DATA_WIDTH)-1:0] matrix [OFMAP_SIZE*OFMAP_SIZE][FILTER_SIZE*FILTER_SIZE-1:0],
    output bit [(2*IP_DATA_WIDTH)-1:0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0]
);

bit [(2*IP_DATA_WIDTH)-1:0] row_sum [OFMAP_SIZE*OFMAP_SIZE-1:0];



always @(*) begin
    // Initialize row sums to zero

    // Calculate sum of each row
    for (int i = 0; i < OFMAP_SIZE*OFMAP_SIZE; i = i + 1) 
    begin
        for (int k = 0; k < FILTER_SIZE*FILTER_SIZE; k = k + 1)
        begin
            //row_sum[i] = row_sum[i] + matrix[i*3 + k];
            row_sum[i] = row_sum[i] + matrix[i][k];
            $display("AM row_sum[%d]=%d", i, row_sum[i]);
        end
    end

    // Input row sums to result matrix
    for (int i = 0; i <OFMAP_SIZE; i = i + 1)
    begin
        for (int j = 0; j <OFMAP_SIZE; j = j + 1) 
        begin
            result_matrix[i][j] = row_sum[i*OFMAP_SIZE+j];
        end
    end
end

endmodule
