//Author: Akshat Mathur
//Code Revisions: 
//
module max_func#(parameter NUMINPUT =10,parameter INPUTWIDTH =16, parameter OPDATA_WIDTH=32)

(
    input clk,
    input [(NUMINPUT*INPUTWIDTH)-1:0] ip_data,
    input ip_valid,
    output bit [OPDATA_WIDTH-1:0] op_data,
    output bit op_data_valid
);

bit [INPUTWIDTH-1:0] maxValue;
bit [(NUMINPUT*INPUTWIDTH)-1:0] inDataBuffer;
int counter;

always @(posedge clk)
begin
    op_data_valid <= 1'b0;
    if(ip_valid)
    begin
        //initializing registers
        //initially putting first block of 16 bits of data in maxvalue
        maxValue <= ip_data[INPUTWIDTH-1:0];
        counter <= 1;
        //initializing input data buffer
        inDataBuffer <= ip_data;
        op_data <= 0;
    end

    // when all data has been covered
    else if(counter == NUMINPUT)
    begin
        counter <= 0;
        op_data_valid <= 1'b1;
    end

    // traversal and checking max value
    else if(counter != 0)
    begin
        counter <= counter + 1;
        if(inDataBuffer[counter*INPUTWIDTH+:INPUTWIDTH] > maxValue)
        begin
            maxValue <= inDataBuffer[counter*INPUTWIDTH+:INPUTWIDTH];
            op_data <= counter;
        end
    end
end

endmodule
