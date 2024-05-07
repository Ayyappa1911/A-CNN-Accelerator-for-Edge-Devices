`timescale 1ns / 1ps


module full_conv_top(input clk, output [15:0] ou1, ou2, ou3, ou4, ou5, ou6);
//module full_conv_top(input clk);

//wire [15:0] ou1, ou2, ou3, ou4, ou5, ou6;



//ila_1 conv_ila (
//	.clk(clk), // input wire clk


//	.probe0(ou1), // input wire [15:0]  probe0  
//	.probe1(ou2), // input wire [15:0]  probe1 
//	.probe2(ou3), // input wire [15:0]  probe2 
//	.probe3(ou4), // input wire [15:0]  probe3 
//	.probe4(ou5), // input wire [15:0]  probe4 
//	.probe5(ou6) // input wire [15:0]  probe5
//);



reg reset = 1;

reg resetflg = 0;


always @(posedge clk) begin
    if(resetflg == 0) begin
        reset = 0;
        resetflg = 1;
    end
    else begin
        reset = 1;
    end
end

parameter N = 7, nok = 6, stride = 5, n = stride, img = 224, im = img-(stride-1);

//logic [N:0] ker11[stride-1:0][stride-1:0];
//logic [N:0] ker12[stride-1:0][stride-1:0];
//logic [N:0] ker13[stride-1:0][stride-1:0];
//logic [N:0] ker14[stride-1:0][stride-1:0];
//logic [N:0] ker15[stride-1:0][stride-1:0];
//logic [N:0] ker16[stride-1:0][stride-1:0];

logic [N:0] ker[0:nok-1][0:stride*stride-1];


//logic [2*N+1:0] out11;
//logic [2*N+1:0] out12;
//logic [2*N+1:0] out13;
//logic [2*N+1:0] out14;
//logic [2*N+1:0] out15;
//logic [2*N+1:0] out16;

logic [2*N+1:0]out[0:nok-1];


reg [N:0] data;
reg data_valid;
wire data_request;
wire finish;
wire valid;
wire [N:0] valid_idx;
wire conv_fin;
reg [11:0] img_len = 224;
reg [2:0] ker_len = 5;

full_conv #(N, nok, stride, n, im, img) full_conv_uut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .data_valid(data_valid),
//        .ker1(ker11),
//        .ker2(ker12),
//        .ker3(ker13),
//        .ker4(ker14),
//        .ker5(ker15),
//        .ker6(ker16),
        .ker(ker),
        .img_len(img_len),
        .ker_len(ker_len),
        
        .data_request(data_request),
//        .out1(out11),
//        .out2(out12),
//        .out3(out13),
//        .out4(out14),
//        .out5(out15),
//        .out6(out16),
        .out(out),
        .finish(finish),
        .valid(valid),
        .valid_idx(valid_idx),
        .conv_fin(conv_fin)
);

//wire [2*N +1 : 0] pool_out1;
//wire [2*N +1 : 0] pool_out2;
//wire [2*N +1 : 0] pool_out3;
//wire [2*N +1 : 0] pool_out4;
//wire [2*N +1 : 0] pool_out5;
//wire [2*N +1 : 0] pool_out6;


//wire pool1_out_valid;
//wire pool1_finish;

//pool_layer #(N, im, 2) pool1 (
//    .clk(clk),
//    .reset(reset),
//    .conv_fin(finish),
    
//    .data1(out11),
//    .data2(out12),
//    .data3(out13),
//    .data4(out14),
//    .data5(out15),
//    .data6(out16),
    
//    .valid(valid),
//    .valid_idx(valid_idx),
    
//    .out1(pool_out1),
//    .out2(pool_out2),
//    .out3(pool_out3),
//    .out4(pool_out4),
//    .out5(pool_out5),
//    .out6(pool_out6),
    
//    .out_valid(pool1_out_valid),
//    .finish(pool1_finish)
//);

//assign ou1 = pool_out1;
//assign ou2 = pool_out2;
//assign ou3 = pool_out3;
//assign ou4 = pool_out4;
//assign ou5 = pool_out5;
//assign ou6 = pool_out6;


//assign ou1 = out11;
//assign ou2 = out12;
//assign ou3 = out13;
//assign ou4 = out14;
//assign ou5 = out15;
//assign ou6 = out16;


assign ou1 = out[0];
assign ou2 = out[1];
assign ou3 = out[2];
assign ou4 = out[3];
assign ou5 = out[4];
assign ou6 = out[5];

integer i = 0;

integer j = 0;

integer k,k1 = 0;
initial begin
          for(k = 0; k < nok; k = k + 1) begin
            for(k1 = 0; k1 < stride*stride; k1 = k1 + 1) begin
                ker[k][k1] = k+1;
            end
          end
//          for(k = 0; k < stride; k = k + 1) begin
//            for(k1 = 0; k1 < stride; k1 = k1 + 1) begin
//                ker12[k][k1] = 2;
//            end
//          end
//          for(k = 0; k < stride; k = k + 1) begin
//            for(k1 = 0; k1 < stride; k1 = k1 + 1) begin
//                ker13[k][k1] = 3;
//            end
//          end
//          for(k = 0; k < stride; k = k + 1) begin
//            for(k1 = 0; k1 < stride; k1 = k1 + 1) begin
//                ker14[k][k1] = 4;
//            end
//          end
//          for(k = 0; k < stride; k = k + 1) begin
//            for(k1 = 0; k1 < stride; k1 = k1 + 1) begin
//                ker15[k][k1] = 5;
//            end
//          end
//          for(k = 0; k < stride; k = k + 1) begin
//            for(k1 = 0; k1 < stride; k1 = k1 + 1) begin
//                ker16[k][k1] = 6;
//            end
//          end
end

int cnt = 0;

always @(posedge clk) begin
    if(resetflg == 1) begin
//        while(i < 1024) begin
            data_valid = 0;
            if(data_request == 1) begin
                data = i;
                i = i + 1;
                data_valid = 1;
            end
            
            if(!conv_fin) begin
                cnt = cnt + 1;
            end
//            if(data_request == 1) begin
//                j = j + 1;
//            end
//        end
    end
end    


    
endmodule



//        ker1[0][0] = -1;
//        ker1[0][1] = -2;
//        ker1[0][2] = 0;
//        ker1[0][3] = 2;
//        ker1[0][4] = 1;
        
//        ker1[1][0] = -4;
//        ker1[1][1] = -8;
//        ker1[1][2] = 0;
//        ker1[1][3] = 8;
//        ker1[1][4] = 4;
        
//        ker1[2][0] = -6;
//        ker1[2][1] = -12;
//        ker1[2][2] = 0;
//        ker1[2][3] = 12;
//        ker1[2][4] = 6;
        
//        ker1[3][0] = -4;
//        ker1[3][1] = -8;
//        ker1[3][2] = 0;
//        ker1[3][3] = 8;
//        ker1[3][4] = 4;
        
//        ker1[4][0] = -1;
//        ker1[4][1] = -2;
//        ker1[4][2] = 0;
//        ker1[4][3] = 2;
//        ker1[4][4] = 1;