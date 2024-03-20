//Author: Akshat Mathur
//Code revisions:

module convolution 
import yolo_params_pkg::*;
(
    input clk, 
    input rst,
    input [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0],
    input [IP_DATA_WIDTH-1:0] filter[FILTER_SIZE-1:0][FILTER_SIZE-1:0],
    output reg [IP_DATA_WIDTH-1:0] ofmap[OFMAP_SIZE-1:0]
);

bit [IP_DATA_WIDTH-1:0] ip_vector[FILTER_SIZE*FILTER_SIZE-1:0];
bit [IP_DATA_WIDTH-1:0] filter_vector[FILTER_SIZE*FILTER_SIZE-1:0];


//converting 2D filter matrix to 1D array
always@(*)
begin
    for(int i=0; i< FILTER_SIZE; i++)
    begin
        for(int j=0; j< FILTER_SIZE; j++)
        begin
            filter_vector[i*FILTER_SIZE + j] = filter[i][j];
        end
    end

end

//Currently supporting max of 5x5 input feature map
always@(*);
begin
    // Traversing Row wise 
    for(int i =0; i < IFMAP_SIZE; i=i+STRIDE)
    begin
        //taking care of vertial strides
        if(i < IFMAP_SIZE -1 && i!= FILTER_SIZE+STRIDE-1 && FILTER_SIZE + STRIDE-1 < IFMAP_SIZE)
        begin
            for(int j=0; j< IFMAP_SIZE; j=j+STRIDE)
            begin

                //Filling 1st register
                if(j!=FILTER_SIZE)
                    reg1[j+j*FILTER_SIZE-1] = ifmap[i][j];

                //Simultaneously filling 2nd register
                if(j!=FILTER_SIZE+STRIDE-1 && j< IFMAP_SIZE-1)
                    reg2[j+j*FILTER_SIZE-1] = ifmap[i][j+STRIDE];

                //Simultaneously filling 3rd register
                if(j!=FILTER_SIZE+ 2*STRIDE-1 && j < IFMAP_SIZE-1)
                    reg3[j+j*FILTER_SIZE-1] = ifmap[i][j + 2*STRIDE];
            end
        end
    end
end


always @(posedge clk)
begin
    if(rst)
    begin
        for(int i =0; i < IFMAP_SIZE; i++)
        begin
            ofmap[i]<= 'b0;
        end
    end
    else
    begin
        //This loop is unrolled
        //TODO check unrolling of loop in Schematic
        for(int i =0; i < IFMAP_SIZE; i++)
        begin
            reg1_mult_out = reg1_mult_out +  reg1[i] * filter_vector[i];
            reg2_mult_out = reg2_mult_out +  reg2[i] * filter_vector[i];
            reg3_mult_out = reg3_mult_out +  reg3[i] * filter_vector[i];

        end
    end

end

endmodule
