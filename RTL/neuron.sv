// Author: Akshat Mathur
// Code updates
// 1. Implementing backprop func
// 2. piecewise linear func = RELU


//`define PRETRAIN
//TODO take care of -ve no.s
//TODO generate weights and activation function memory in the neuron itself based on layer and neuron no.
//TODO consider registers instead of memory for weights - DISCUSS
module neuron #(parameter ACT_FN="SIGMOID", IP_DATA_WIDTH=8, NUM_IP=8, ACT_FN_SIZE=5 )
(
    input clk,
    input rst,
    input signed [IP_DATA_WIDTH-1:0] x [NUM_IP-1:0],
    input signed [IP_DATA_WIDTH-1:0] wt_in [NUM_IP-1:0],
    input update_wts,
    output bit signed [IP_DATA_WIDTH-1:0] out
);

bit signed [2*IP_DATA_WIDTH-1:0] sum_out;
bit signed [IP_DATA_WIDTH-1:0] x_d [NUM_IP-1:0];

bit [$clog2(IP_DATA_WIDTH)-1:0] count;
bit [$clog2(NUM_IP)-1:0] wt_count;

// Weight ROM
bit signed [IP_DATA_WIDTH-1:0] wt_mem [NUM_IP-1:0];

`ifdef PRETRAIN
    initial begin
        $readmemb("wt_mem.init", wt_mem);
    end
//`elsif RANDOMIZE
//    initial begin
//        for (int i=0 ; i<NUM_IP;i++ ) 
//        begin
//            wt_mem[i] = $random; //TODO take care of -ve no.s
//            $display("wt_mem[%h]=%h", i, wt_mem[i]);
//
//        end
//    end
`else  // BACKPROP
    always @(posedge clk)
    begin
        //Writing back into wt_mem updated weigths when wt_in is enabled
        if(update_wts)
        begin
            wt_mem[wt_count] <= wt_in[wt_count];
            wt_count <= wt_count +1; 
        end


    end

  
`endif

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
    if(ACT_FN=="SIGMOID")
        sigmoid_func #(.MEM_WIDTH(ACT_FN_SIZE), .DATA_WIDTH(IP_DATA_WIDTH)) inst_sigmoid_func
        (
            .clk(clk),
            .in(sum_out[2*IP_DATA_WIDTH-1-:ACT_FN_SIZE]), // passing 5 bits
            .mem_out(out)         // getting value from activation function

        );
    else
        relu_func #(.MEM_WIDTH(ACT_FN_SIZE), .DATA_WIDTH(IP_DATA_WIDTH)) inst_relu_func
            (
                .clk(clk),
                .in(sum_out[2*IP_DATA_WIDTH-1-:ACT_FN_SIZE]), // pasing 5 bits
                .mem_out(out)         // getting value from activation function

            );
endgenerate


    
endmodule     
