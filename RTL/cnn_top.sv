`include "yolo_params_include.sv"
module cnn_top #(parameter IP_LAYER_NEURONS=RESULT_WIDTH*RESULT_WIDTH, ACT_FN="RELU", NUM_IP=1, ACT_FN_SIZE=5, DENSE_LAYER=1, DENSE_LAYER_NEURONS=2)
(
    input clk,
    input rst,
    input bit [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0], // input image
    input bit [IP_DATA_WIDTH-1:0] filter [FILTER_SIZE-1:0][FILTER_SIZE-1:0], // filter for convolution
    input signed [2*IP_DATA_WIDTH-1:0] wt_in [(IP_LAYER_NEURONS*NUM_IP)-1:0], // input to input layer of fully connected 
    input signed [2*IP_DATA_WIDTH-1:0]wt_temp[IP_LAYER_NEURONS], // input to dense layer to fully connected
    input signed [2*IP_DATA_WIDTH-1:0]wt_dense[DENSE_LAYER_NEURONS], // input to final layer of fully connected
    input update_wts, // handshaking signal to fully connected 
    output bit op_data_valid, //handshaking signal coming from max func
    output signed [2*IP_DATA_WIDTH-1:0] out // final output from cnn top
);


// Connecting wires

bit [(2*IP_DATA_WIDTH)-1:0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0];
bit signed [2*IP_DATA_WIDTH-1:0] max_pooling_result [RESULT_WIDTH*RESULT_WIDTH-1:0];
bit signed [2*IP_DATA_WIDTH-1:0] input_vec [OFMAP_SIZE*OFMAP_SIZE-1:0];
bit signed [IP_DATA_WIDTH-1:0] full_conn_layer_out;


convolution inst_convolution
(
    .ifmap(ifmap),
    .filter(filter),
    .result_matrix(result_matrix)
);

//converting result matrix to 1D vector
generate 
  for(genvar p=0; p< ARRAY_WIDTH; p++)
  begin
      for(genvar q=0; q<ARRAY_WIDTH; q++)
      begin
          assign input_vec[p*ARRAY_WIDTH + q] = result_matrix[p][q];
      end
  end
endgenerate

max_pooling #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .ARRAY_WIDTH(ARRAY_WIDTH), .POOL_FILTER_SIZE(POOL_FILTER_SIZE) ,.POOL_STRIDE(POOL_STRIDE), .RESULT_WIDTH(RESULT_WIDTH)) inst_max_pooling
(
    .input_vec(input_vec),
    .result(max_pooling_result)
);

//Flattening already done here

fully_connected_layer #(.IP_DATA_WIDTH(IP_DATA_WIDTH), .IP_LAYER_NEURONS(IP_LAYER_NEURONS), .ACT_FN("RELU"), .NUM_IP(1), .ACT_FN_SIZE(5), .DENSE_LAYER(1), .DENSE_LAYER_NEURONS(2)) inst_fully_connected_layer 
(
    .clk(clk),
    .rst(rst),
    .x(max_pooling_result),
    .wt_in(wt_in),
    .wt_temp(wt_temp),
    .wt_dense(wt_dense),
    .update_wts(update_wts),
    .out(full_conn_layer_out)

);



max_func #(.NUMINPUT(1), .INPUTWIDTH(2**IP_DATA_WIDTH), .OPDATA_WIDTH(2**IP_DATA_WIDTH)) inst_max_func

(
    .clk(clk),
    .ip_data(full_conn_layer_out),
    .ip_valid(1),
    .op_data(out),
    .op_data_valid(op_data_valid)
);


endmodule
