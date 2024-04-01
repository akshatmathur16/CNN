//Author: Akshat Mathur
//Code revisions:

module convolution 
import yolo_params_pkg::*;
(
    input bit [IP_DATA_WIDTH-1:0] ifmap[IFMAP_SIZE-1:0][IFMAP_SIZE-1:0],
    input bit [IP_DATA_WIDTH-1:0] filter [FILTER_SIZE-1:0][FILTER_SIZE-1:0],
    output bit [(2*IP_DATA_WIDTH):0] result_matrix [OFMAP_SIZE-1:0][OFMAP_SIZE-1:0]

);

bit [IP_DATA_WIDTH-1:0] reg1[FILTER_SIZE*FILTER_SIZE-1:0];
bit [IP_DATA_WIDTH-1:0] reg2[FILTER_SIZE*FILTER_SIZE-1:0];
bit [IP_DATA_WIDTH-1:0] reg3[FILTER_SIZE*FILTER_SIZE-1:0];

bit [IP_DATA_WIDTH-1:0] filter_vector [FILTER_SIZE*FILTER_SIZE-1:0];
bit [(IP_DATA_WIDTH + IP_DATA_WIDTH )-1:0] op_vec[FILTER_SIZE*FILTER_SIZE-1:0];

generate 
    for(genvar p=0; p< FILTER_SIZE; p++)
    begin
        for(genvar q=0; q< FILTER_SIZE; q++)
        begin
            assign filter_vector[p*FILTER_SIZE + q] = filter[p][q];
        end
    end


endgenerate


//generate

  // overflow condition taken care by using OFMAP_SIZE
  // since any loop will run max till OFMAP_SIZE
  // also OFMAP_SIZE calculation includes stride

 //AM  for(genvar i =0; i < OFMAP_SIZE; i++) 
 //AM  begin
 //AM      //if(i+STRIDE < OFMAP_SIZE)
 //AM      begin
 //AM          for(genvar j=0; j< OFMAP_SIZE; j++) 
 //AM          begin
 //AM              assign reg1[j+i*FILTER_SIZE] = ifmap[i][j]; 
 //AM              assign reg2[j+i*FILTER_SIZE] = (i+STRIDE<= OFMAP_SIZE) ? ifmap[i][j+STRIDE]:reg2[j+i*FILTER_SIZE] ; 
 //AM              assign reg3[j+i*FILTER_SIZE] = (i+STRIDE<= OFMAP_SIZE) ? ifmap[i][j+2*STRIDE]:reg3[j+i*FILTER_SIZE]; 

 //AM          end
 //AM      end
 //AM  end
 //AM for(genvar p=0; p< FILTER_SIZE * FILTER_SIZE; p++)
//AM begin
//AM     assign op_vec[p]=reg1[p]*filter_vector[p];
//AM end
//AM
//AM
//AMendgenerate
 
generate

//bit [IP_DATA_WIDTH-1:0] temp_reg [FILTER_SIZE*FILTER_SIZE-1:0][OFMAP_SIZE*OFMAP_SIZE];
bit [(2*IP_DATA_WIDTH)-1:0] temp_reg[OFMAP_SIZE*OFMAP_SIZE] [FILTER_SIZE*FILTER_SIZE-1:0];

for(genvar i=0; i<OFMAP_SIZE*OFMAP_SIZE; i++)
begin

    for(genvar j=0; j <FILTER_SIZE; j++)
    begin

        for(genvar k=0; k<FILTER_SIZE; k++)
        begin

            assign temp_reg[i][FILTER_SIZE*FILTER_SIZE - (k+j*FILTER_SIZE) -1] = ifmap[j + (i/OFMAP_SIZE)*STRIDE][k + (i%OFMAP_SIZE)*STRIDE] * filter[j][k];
        end
    end
  end

endgenerate




initial begin
        $monitor($time,"op_vec=%p",op_vec);
end

always @(op_vec[FILTER_SIZE*FILTER_SIZE-1])
begin
    $display("Entering always block");
    for(int i=0; i< FILTER_SIZE*FILTER_SIZE; i++)
    begin
        op = op+op_vec[i];
    end

end





endmodule
