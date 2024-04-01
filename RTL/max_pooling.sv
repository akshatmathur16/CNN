module max_pooling
//import max_pool_pkg::*;
import yolo_params_pkg::*;
(
    input bit [IP_DATA_WIDTH:0] input_vec [0:(ARRAY_WIDTH*ARRAY_WIDTH)-1],
    output bit [IP_DATA_WIDTH:0] result [0:RESULT_WIDTH*RESULT_WIDTH-1]
);
     
bit [IP_DATA_WIDTH-1:0] max_val;

always @(*)
begin
    // for Input matrix row
    for (int i = 0; i < ARRAY_WIDTH - POOL_FILTER_SIZE + 1; i = i + POOL_STRIDE)
    begin 
      // for Input matrix column
      for (int j = 0; j < ARRAY_WIDTH - POOL_FILTER_SIZE + 1; j = j + POOL_STRIDE) 
      begin 
        max_val = input_vec[i * ARRAY_WIDTH + j];

        //for filter row
        for (int k = 0; k < POOL_FILTER_SIZE; k = k + 1) 
        begin 
          //for filter column
          for (int l = 0; l < POOL_FILTER_SIZE; l = l + 1) 
          begin 
              if (input_vec[(i + k) * ARRAY_WIDTH + (j + l)] > max_val) 
              begin
                  max_val = input_vec[(i + k) * ARRAY_WIDTH + (j + l)];
              end
          end
        end
        result[(i / POOL_STRIDE) * RESULT_WIDTH + (j / POOL_STRIDE)] = max_val;
      end
    end
end

endmodule


