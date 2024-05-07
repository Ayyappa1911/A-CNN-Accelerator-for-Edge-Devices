`timescale 1ns / 1ps

module full_conv#(parameter N = 7, nok = 3, stride = 5, n = 5, im = 28, img = im + (stride-1))(
        input clk,
        input reset,
        input [N:0] data,
        input data_valid,

        input [N:0] ker[0:nok-1][0:stride*stride-1],
        input [11:0] img_len,
        input [2:0] ker_len,
        
        output reg data_request,

        output [2*N+1:0]out[0:nok-1],
        
        output reg finish,
        output valid,
        output reg [11:0] valid_idx,
        output reg conv_fin
);

(* dont_touch = "yes" *) logic [N:0]array[0:(stride-1)][0:(img-1)];

(* dont_touch = "yes" *) logic [N:0]inp_array[0:(stride-1)];

reg restart = 0;

reg resflg = 0;
reg [1:0] finflg;


logic [0:nok-1] valid_t;

assign valid = (valid_t == {nok{1'b1}}) ? 1 : 0;

reg [9:0] fifo_idx;

wire conv_restart;
assign conv_restart = reset && restart;


reg [9:0] conv_j = 0;
reg conv_inp_valid = 0;

reg [4:0] conv_k;

reg [4:0] conv_flg = -1;

reg datflg = 0;

genvar ker_itr;

generate
    
    for(ker_itr = 0; ker_itr< nok; ker_itr++) begin
        conv #(N,stride,n,im,img) conv_ut1 (
            .clk(clk),
            .ker(ker[ker_itr][(n*conv_flg -n)+: n]),
            .array(inp_array),
            .reset(conv_restart),
            .ker_len(ker_len),
            .inp_valid(conv_inp_valid),
            .out(out[ker_itr]),
            .valid(valid_t[ker_itr])
);
    end

endgenerate


always @(posedge clk or negedge (conv_restart)) begin
    if(!(conv_restart)) begin
        finish = 0;
        valid_idx = 0;
        conv_j = 0;
        conv_flg = 0;
        conv_inp_valid = 0;
    end
    else begin
    
        if(conv_flg == ker_len) begin
            conv_flg = 0;
            conv_j = conv_j + 1;
        end
        
        if(conv_flg < ker_len) begin
            for(conv_k = 0; conv_k < stride; conv_k = conv_k + 1) begin
                inp_array[conv_k] = array[conv_flg][conv_j + conv_k];
            end

            conv_inp_valid = 1;
        end
        else begin
            conv_inp_valid = 0;
        end
    
        conv_flg = conv_flg + 1;

        if(valid == 1) begin
            valid_idx = valid_idx + 1;
            
            if(valid_idx == (img_len)-(ker_len - 1)) begin
                conv_j = 0;
                finish = 1;    
            end
        end
    end
end


reg [9:0] j,k,j_tmp;

reg [9:0] i,out_i;

always @(posedge clk or negedge reset) begin
    restart = 1;
    if(!reset) begin
        i = 0;
        j = 0;
        restart = 0;
        data_request = 1;
        fifo_idx = -1;
        resflg = 0;
        conv_fin = 0;
        out_i = 0;
        finflg = 0;
    end
    else begin
        if(finflg == 1) begin
            out_i = out_i + 1;
            finflg = 2;
        end
        
        data_request = 0;

        if(i < ker_len - 1 || (i == ker_len - 1 && j < ker_len) ) begin
            data_request = 1;
            restart = 0;
            if(data_valid == 1) begin
                array[i][j] = data;
            end
        end
        
        else if(i == ker_len - 1 && j >= ker_len && j < img_len) begin
            restart = 1;
            data_request = 1;
            if(valid == 1) begin
                fifo_idx = fifo_idx + 1;
                
                for(k = 0; k < stride-1; k = k + 1) begin
                    array[k][fifo_idx] = array[k+1][fifo_idx];
                end
            end
            
            if(data_valid == 1) begin
                array[i][j] = data;
            end
        end
        else begin
            data_request = 0;
            if(valid == 1) begin
                fifo_idx = fifo_idx + 1;
                
                data_request = 1;
                
                for(k = 0; k < stride-1; k = k + 1) begin
                    array[k][fifo_idx] = array[k+1][fifo_idx];
                end
            end
            
            if(data_valid == 1) begin
                array[ker_len-1][j] = data;
            end
        end
        
        if(finish == 1) begin
            restart = 0;
            resflg = 1;
            finflg = !(finflg) ? 1 : 0;
        end
        
        if(resflg && fifo_idx != img_len - 1) begin
            data_request = 1;
            for(k = 0; k < stride-1; k = k + 1) begin
                array[k][fifo_idx + 1] = array[k+1][fifo_idx + 1];
            end
            fifo_idx = fifo_idx + 1; 
        end
        
        if(fifo_idx == img_len -(ker_len - 1) + 1) begin
            restart = 1;
            finflg = 0;
        end
        
        if(resflg && fifo_idx == img_len - 1) begin
            resflg = 0;
            fifo_idx = -1;
//            data_request = 1;
//            if(j < ker_len || j > img_len - ker_len) begin
                datflg = 1;
//            end
        end
        
        if(datflg && valid_idx == 0 && j < ker_len) begin
            data_request = 1;
        end
        else if(datflg && valid_idx == 0 && j == ker_len) begin
            datflg = 0;
            data_request = 0;
        end
        
        if(data_valid == 1) begin
            j = j + 1;
        end
        
        j_tmp = j;
        
        // optimize here ////////////////////////
        
//        if(i > out_i + ker_len - 1) begin
//            if(fifo_idx <= j_tmp) begin
//                data_request = 0;
//            end
//        end
        
//        if(i == out_i + ker_len - 1) begin
//            if((j_tmp > img_len - 4) && (fifo_idx > img_len) && img_len > ker_len) begin
//                data_request = 0;
//            end
//            if(j == img_len - 1) begin
//                data_request = 0;
//            end
//        end
        
        if(img_len == ker_len && j_tmp == ker_len - 1) begin
            data_request = 0;
        end
        
        ///////////////////////////////////////

        if(j == img_len) begin
            j = 0; 
            if(i < img_len) begin
                i = i + 1;
            end
        end
        
        if(i == img_len) begin
            data_request = 0;
        end
        
        if(out_i == img_len - (ker_len - 1) ) begin
            conv_fin = 1;
            restart = 0;
        end
        
    end
end
endmodule
