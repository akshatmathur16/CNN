module tb_conv_mac();
import yolo_params_pkg::*;

bit clk;
bit [(2*IP_DATA_WIDTH)-1:0] matrix [OFMAP_SIZE*OFMAP_SIZE][FILTER_SIZE*FILTER_SIZE-1:0];
bit [(2*IP_DATA_WIDTH):0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0];

conv_mac inst_conv_mac
(
    .clk(clk),
    .matrix(matrix),
    .result_matrix(result_matrix)
);


initial begin

    for(int i=0; i<OFMAP_SIZE*OFMAP_SIZE; i++)
    begin
        for(int j=0; j<FILTER_SIZE*FILTER_SIZE; j++)
        begin
            matrix[i][j] = i;
        end
    end

  
end

initial begin
    $monitor($time, " matrix=%p, result_matrix=%p",matrix, result_matrix);


    #100 $stop;
end






endmodule
