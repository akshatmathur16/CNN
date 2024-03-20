module tb_max_func();

parameter NUMINPUT =10;
parameter INPUTWIDTH =16;
parameter OPDATA_WIDTH=32;


bit clk;
bit [(NUMINPUT*INPUTWIDTH)-1:0] ip_data;
bit ip_valid;
bit [OPDATA_WIDTH-1:0] op_data;
bit op_data_valid;



max_func#(.NUMINPUT(NUMINPUT), .INPUTWIDTH(INPUTWIDTH), .OPDATA_WIDTH(OPDATA_WIDTH)) inst_max_func
(
    .clk(clk),
    .ip_data(ip_data),
    .ip_valid(ip_valid),
    .op_data(op_data),
    .op_data_valid(op_data_valid)
);


    initial begin
        //#4 ip_data  = $urandom_range('hF5F5_F9F9_AAAA_5555_5555_5555, 0); ip_valid = 'b1;
        #4 ip_data  = 'hF5F5_F9F9_AAAA_5555_5555_5555; ip_valid = 'b1;
        #10 ip_valid = 'b0;
        #104 ip_data = 'hAAAA_BBBB_F5F5_DDDD_AAAA_5555_5555_5555; ip_valid = 'b1;
        #10 ip_valid = 'b0;
        #204 ip_data = $urandom_range('hF5F5_F9F9_AAAA_5555_5555_5555, 0); ip_valid = 'b0;
        #304 ip_data = $urandom_range('hF5F5_F9F9_AAAA_5555_5555_5555, 0); ip_valid = 'b0;
        #404 ip_data = $urandom_range('hF5F5_F9F9_AAAA_5555_5555_5555, 0); ip_valid = 'b0;
        #504 ip_data = $urandom_range('hF5F5_F9F9_AAAA_5555_5555_5555, 0); ip_valid = 'b0;
        #604 ip_data = $urandom_range('hF5F5_F9F9_AAAA_5555_5555_5555, 0); ip_valid = 'b0;
    end





    always 
        #5 clk = ~clk;

    initial begin
        #1000 $stop;
    end

endmodule
