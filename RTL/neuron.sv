// Author: Akshat Mathur
// Code updates
// 1. Implementing backprop func
// 2. piecewise linear func = RELU


`define PRETRAIN
//TODO take care of -ve no.s
//TODO generate weights and activation function memory in the neuron itself based on layer and neuron no.
//TODO consider registers instead of memory for weights - DISCUSS
module neuron #(parameter IP_DATA_WIDTH=8, WT_WIDTH=8, ACT_FN="RELU", NUM_IP=1, ACT_FN_SIZE=5,DENSE_LAYER=1,DENSE_LAYER_NEURONS=2)
//import yolo_params_pkg::*;
(
    input clk,
    input rst,
    input signed [IP_DATA_WIDTH-1:0] x [NUM_IP-1:0],
    //input signed [WT_WIDTH-1:0] wt_in [NUM_IP-1:0],
    output bit signed [(WT_WIDTH+IP_DATA_WIDTH)-1:0] out
);

bit signed [(WT_WIDTH+IP_DATA_WIDTH)-1:0] sum_out;
bit signed [IP_DATA_WIDTH-1:0] x_d [NUM_IP-1:0];

bit [$clog2(IP_DATA_WIDTH)-1:0] count;
//bit [$clog2(NUM_IP)-1:0] wt_count;

// Weight ROM
bit signed [WT_WIDTH-1:0] wt_mem [NUM_IP-1:0];

//Initializing weight ROM
initial begin
    $readmemb("wt_mem.init", wt_mem);
end

// Delaying input by 1 clock cycle
always @(posedge clk) begin
    if(rst)
    begin
        for(int i=0; i<NUM_IP; i++ )
        begin
            x_d[i] <= 'b0;
        end
    end
    else
    begin
        for(int i=0; i<NUM_IP; i++ )
        begin
            x_d[i] <= x[i];
        end
    end
end

always @(posedge clk) begin
    if(rst)
    begin
        sum_out <= 'b0;
        //out <= 'b0;
        count<='b0;
    end
    else
    begin
        // MAC functionality
        sum_out <= sum_out + x_d[count] * wt_mem[count];
        if(count=='d7)
            count<= 'b0;
        else
            count <= count+1;

    end
    
end


generate

    if(ACT_FN=="RELU")
        relu_func #(.IP_DATA_WIDTH(WT_WIDTH+IP_DATA_WIDTH)) inst_relu_func
            (
                .clk(clk),
                .in(sum_out), 
                .act_out(out)        

            );
endgenerate

    
endmodule     
