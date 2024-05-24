
module relu_func #(parameter IP_DATA_WIDTH=8)
(
    input clk,
    input [IP_DATA_WIDTH-1:0] in,
    output reg signed [IP_DATA_WIDTH-1:0] act_out

);


always@(posedge clk)
begin
    //TODO take care of negative no.s

    if($signed(in) <= 0)
        act_out <= 'b0;
    else
        act_out <= in;
end

endmodule
