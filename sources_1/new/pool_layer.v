`timescale 1ns / 1ps

module pool_layer#(parameter N = 7, im = 28, pool_stride = 3) (
    input clk,
    input reset,
    input conv_fin,
    
    input [2*N + 1 : 0] data1,
    input [2*N + 1 : 0] data2,
    input [2*N + 1 : 0] data3,
    input [2*N + 1 : 0] data4,
    input [2*N + 1 : 0] data5,
    input [2*N + 1 : 0] data6,
    
    input valid,
    input [N:0] valid_idx,
    
    output [2*N+1 : 0] out1,
    output [2*N+1 : 0] out2,
    output [2*N+1 : 0] out3,
    output [2*N+1 : 0] out4,
    output [2*N+1 : 0] out5,
    output [2*N+1 : 0] out6,
    
    
    output out_valid,
    output finish
    );
    
wire out_valid1, out_valid2, out_valid3, out_valid4, out_valid5, out_valid6;
wire finish1, finish2, finish3, finish4, finish5, finish6;

assign out_valid = out_valid1 || out_valid2 || out_valid3 || out_valid4 || out_valid5 || out_valid6;
assign finish = finish1 || finish2 || finish3 || finish4 || finish5 || finish6;

pool #(N, im, pool_stride) pool1 (
    .clk(clk),
    .reset(reset),
    .conv_fin(conv_fin),
    .data(data1),
    .valid(valid),
    .valid_idx(valid_idx),
    .out(out1),
    .out_valid(out_valid1),
    .finish(finish1)
);

pool #(N, im, pool_stride) pool2 (
    .clk(clk),
    .reset(reset),
    .conv_fin(conv_fin),
    .data(data2),
    .valid(valid),
    .valid_idx(valid_idx),
    .out(out2),
    .out_valid(out_valid2),
    .finish(finish2)
);

pool #(N, im, pool_stride) pool3 (
    .clk(clk),
    .reset(reset),
    .conv_fin(conv_fin),
    .data(data3),
    .valid(valid),
    .valid_idx(valid_idx),
    .out(out3),
    .out_valid(out_valid3),
    .finish(finish3)
);

pool #(N, im, pool_stride) pool4 (
    .clk(clk),
    .reset(reset),
    .conv_fin(conv_fin),
    .data(data4),
    .valid(valid),
    .valid_idx(valid_idx),
    .out(out4),
    .out_valid(out_valid4),
    .finish(finish4)
);

pool #(N, im, pool_stride) pool5 (
    .clk(clk),
    .reset(reset),
    .conv_fin(conv_fin),
    .data(data5),
    .valid(valid),
    .valid_idx(valid_idx),
    .out(out5),
    .out_valid(out_valid5),
    .finish(finish5)
);

pool #(N, im, pool_stride) pool6 (
    .clk(clk),
    .reset(reset),
    .conv_fin(conv_fin),
    .data(data6),
    .valid(valid),
    .valid_idx(valid_idx),
    .out(out6),
    .out_valid(out_valid6),
    .finish(finish6)
);


endmodule
