`timescale 1ns / 1ps


module pool #(parameter N = 7, im = 28, pool_stride = 2) (
    input clk,
    input reset,
    input conv_fin,
    input [2*N + 1 : 0] data,
    input valid,
    input [N:0] valid_idx,
    output reg [2*N+1 : 0] out,
    output reg out_valid,
    output reg finish
    );
    

reg [2*N+1 : 0] out_buf [0:(im/2) - 1];   

//integer out_idx;

integer i;
reg [N:0] str;

//reg rst;

always @(posedge clk or negedge reset) begin
    if(!reset) begin
        for(i = 0; i< im/2; i = i + 1) begin
            out_buf[i] = 0;
        end
        str = 0;
        out = 0;
        out_valid = 0;
    end
    else begin
    
        if(finish) begin
            out_valid = 0;
            for(i = 0; i< im/2; i = i + 1) begin
                out_buf[i] = 0;
            end
            out = 0;
        end
        finish = 0;
        
        if(valid) begin
            // Max pool
            if(out_buf[valid_idx/pool_stride] < data) begin
                out_buf[valid_idx/pool_stride] = data;
            end      
        end
        
        if(str == pool_stride - 1 && (valid_idx%pool_stride == 0) && valid_idx != 0) begin
            out_valid = 1;
            out = out_buf[(valid_idx/pool_stride) - 1];
        end
//        else begin
//            out_valid = 0;
//            out = 0;
//        end


        if(conv_fin) begin
            str = str + 1;
//            out = 0;
        end
        
        if(str == pool_stride) begin
            finish = 1;
            str = 0;
        end
    end
end

endmodule
