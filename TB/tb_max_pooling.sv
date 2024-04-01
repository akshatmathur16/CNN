module tb_max_pooling();
import yolo_params_pkg::*;

    bit clk;

    bit [IP_DATA_WIDTH:0] input_vec [0:(ARRAY_WIDTH*ARRAY_WIDTH)-1];
    bit [IP_DATA_WIDTH:0] result [0:RESULT_WIDTH*RESULT_WIDTH-1];


     max_pooling inst_max_pooling
    (
        .input_vec(input_vec),
        .result(result)
    );


    initial begin
        #4;
        for(int i=0; i< ARRAY_WIDTH* ARRAY_WIDTH; i++)
        begin
            input_vec[i] = i;
        end

    end

    always 
        #5 clk=~clk;
    initial 
        #100 $stop;


endmodule
