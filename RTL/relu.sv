
module relu_func #(parameter MEM_WIDTH=5, DATA_WIDTH=8)
(
    input clk,
    input [MEM_WIDTH-1:0] in,
    output reg signed [DATA_WIDTH-1:0] mem_out

);

bit [DATA_WIDTH-1:0] mem [2**MEM_WIDTH-1:0];

always@(posedge clk)
begin
    //TODO take care of negative no.s
    //if($signed(in) < 0) //negative no.
    //begin
    //    mem_out_temp <= mem[]; 
    //end

    if($signed(in) <= 0)
        mem_out[0] <= 'b0;
    else
        mem_out[0] <= mem[in];
end

endmodule
