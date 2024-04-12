module sigmoid_func #(parameter MEM_WIDTH=5, IP_DATA_WIDTH=8)
(
    input clk,
    input [MEM_WIDTH-1:0] in, // passing as an address to retrive value from mem
    output reg signed [IP_DATA_WIDTH-1:0] mem_out

);

bit [IP_DATA_WIDTH-1:0] mem [2**MEM_WIDTH-1:0];

initial begin
    $readmemb("sigmem.txt", mem);
end

always@(posedge clk)
begin
    //TODO take care of negative no.s
    //if($signed(in) < 0) //negative no.
    //begin
    //    mem_out_temp <= mem[]; 
    //end
    mem_out <= mem[in];
end

endmodule
