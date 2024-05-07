`timescale 1ns / 1ps


module inp_conv #(parameter N = 7, stride = 5, n = 5, im = 28, img = im + (stride-1)) (
        input clk,
        input [N:0]ker[stride-1:0][stride-1:0],
        input [N:0]array[0:(stride-1)][0:(img-1)],
        input reset,
                
        output [2*N+1:0]out,
        output finish,
        output valid,
        output [N:0] valid_idx
);

    

endmodule

//`timescale 1ns / 1ps

//module inp_conv#(parameter N = 7, stride = 5, n = 5, im = 28, img = im + (stride-1))(
//        input clk,
//        input reset,
//        input [N:0] data,
//        input data_valid,
//        input [N:0]ker1[stride-1:0][stride-1:0],
//        input [N:0]ker2[stride-1:0][stride-1:0],
//        input [N:0]ker3[stride-1:0][stride-1:0],
//        input [N:0]ker4[stride-1:0][stride-1:0],
//        input [N:0]ker5[stride-1:0][stride-1:0],
//        input [N:0]ker6[stride-1:0][stride-1:0],
        
//        output reg data_request,
//        output [2*N+1:0]out1,
//        output [2*N+1:0]out2,
//        output [2*N+1:0]out3,
//        output [2*N+1:0]out4,
//        output [2*N+1:0]out5,
//        output [2*N+1:0]out6,
        
//        output finish,
//        output valid,
//        output [N:0] valid_idx
//);

//(* dont_touch = "yes" *) logic [N:0]array[0:(stride-1)][0:(img-1)];
//reg restart = 0;

////reg hold = 0;

//reg resflg = 0;

////reg [4:0] itr;
////wire valid;
//integer out_i = 0;

///////////////
////reg [15:0] Aout[0:28*28 - 1];
////////////////////////

//wire finish1;
//wire valid1;
//wire [N:0] valid_idx1;

//wire finish2;
//wire valid2;
//wire [N:0] valid_idx2;

//wire finish3;
//wire valid3;
//wire [N:0] valid_idx3;

//wire finish4;
//wire valid4;
//wire [N:0] valid_idx4;

//wire finish5;
//wire valid5;
//wire [N:0] valid_idx5;

//wire finish6;
//wire valid6;
//wire [N:0] valid_idx6;


//assign finish = finish1 || finish2 || finish3 || finish4 || finish5 || finish6;
//assign valid = valid1 || valid2 || valid3 || valid4 || valid5 || valid6;
//assign valid_idx = valid_idx1;
////assign finish = finish1;
////assign valid = valid1;

//reg [11:0] fifo_idx;
//conv #(N,stride,n,im,img) conv_ut1 (
//        .clk(clk),
//        .ker(ker1),
//        .array(array),
//        .reset(reset && restart),
////        .hold(hold),
//        .out(out1),
//        .finish(finish1),
//        .valid(valid1),
//        .valid_idx(valid_idx1)
//);
//conv #(N,stride,n,im,img) conv_ut2 (
//        .clk(clk),
//        .ker(ker2),
//        .array(array),
//        .reset(reset && restart),
////        .hold(hold),
//        .out(out2),
//        .finish(finish2),
//        .valid(valid2),
//        .valid_idx(valid_idx2)
//);
//conv #(N,stride,n,im,img) conv_ut3 (
//        .clk(clk),
//        .ker(ker3),
//        .array(array),
//        .reset(reset && restart),
////        .hold(hold),
//        .out(out3),
//        .finish(finish3),
//        .valid(valid3),
//        .valid_idx(valid_idx3)
//);
//conv #(N,stride,n,im,img) conv_ut4 (
//        .clk(clk),
//        .ker(ker4),
//        .array(array),
//        .reset(reset && restart),
////        .hold(hold),
//        .out(out4),
//        .finish(finish4),
//        .valid(valid4),
//        .valid_idx(valid_idx4)
//);
//conv #(N,stride,n,im,img) conv_ut5 (
//        .clk(clk),
//        .ker(ker5),
//        .array(array),
//        .reset(reset && restart),
////        .hold(hold),
//        .out(out5),
//        .finish(finish5),
//        .valid(valid5),
//        .valid_idx(valid_idx5)
//);
//conv #(N,stride,n,im,img) conv_ut6 (
//        .clk(clk),
//        .ker(ker6),
//        .array(array),
//        .reset(reset && restart),
////        .hold(hold),
//        .out(out6),
//        .finish(finish6),
//        .valid(valid6),
//        .valid_idx(valid_idx6)
//);

//reg [11:0] j,k;

//reg [4:0] i;

//always @(posedge clk or negedge reset) begin
//    restart = 1;
//    if(!reset) begin
//        i = 0;
//        j = 0;
//        restart = 0;
//        data_request = 1;
//        fifo_idx = -1;
////        hold = 0;
//        resflg = 0;
//    end
//    else begin
//        data_request = 0;
//        if(i < stride - 1 || (i == stride - 1 && j < stride) ) begin
//            data_request = 1;
//            restart = 0;
//            if(data_valid == 1) begin
//                array[i][j] = data;
//            end
//        end
//        else if(i == stride - 1 && j >= stride && j < img) begin
//            restart = 1;
//            data_request = 1;
//            if(valid == 1) begin
//                fifo_idx = fifo_idx + 1;
////                if(fifo_idx + stride >= j) begin
////                    hold = 1;
////                end
//                for(k = 0; k < stride-1; k = k + 1) begin
//                    array[k][fifo_idx] = array[k+1][fifo_idx];
//                end
//            end
            
//            if(data_valid == 1) begin
////                hold = 0;
//                array[i][j] = data;
//            end
//        end
//        else if(i == stride) begin
//            data_request = 0;
//            if(valid == 1) begin
//                fifo_idx = fifo_idx + 1;
                
                
//                // doesn't support very slower data rates or very fast data rates
////                if(fifo_idx + stride >= j) begin
////                    hold = 1;
////                end 
                
//                data_request = 1;
                
//                for(k = 0; k < stride-1; k = k + 1) begin
//                    array[k][fifo_idx] = array[k+1][fifo_idx];
//                end
//            end
            
//            if(data_valid == 1) begin
////                hold = 0;
//                array[i-1][j] = data;
//            end
//        end
        
////        if(hold) begin
////            data_request = 1;
////        end
        
//        if(finish == 1) begin
//            restart = 0;
//            resflg = 1;
////            itr = 0;
//        end
        
//        if(resflg && fifo_idx != img - 1) begin
////            restart = 0;
//            data_request = 1;
//            for(k = 0; k < stride-1; k = k + 1) begin
//                array[k][fifo_idx + 1] = array[k+1][fifo_idx + 1];
//            end
////            itr = itr + 1;
//            fifo_idx = fifo_idx + 1; 
//        end
        
//        if(fifo_idx == im + 1) begin
//            restart = 1;
//        end
        
//        if(resflg && fifo_idx == img - 1) begin
//            resflg = 0;
////            restart = 1;
//            fifo_idx = -1;
//        end
        
//        if(data_valid == 1) begin
//            j = j + 1;
//        end
        
//        //////////////////////////////
////        if(valid == 1 && (out1[valid_idx] >= 0 || out1[valid_idx] < 0)) begin
////            Aout[out_i] = out1[valid_idx];
////            out_i = out_i + 1;
////        end
////        if(out_i == 28*28 - 1) begin
////            $writememb("seven_sobel_left.txt",Aout);
////        end
//        ////////////////////////////////////
        
//        if(j == img) begin
//            j = 0; 
//            if(i < stride) begin
//                i = i + 1;
//            end
//        end
//    end
//end
//endmodule

