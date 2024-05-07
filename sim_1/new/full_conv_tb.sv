`timescale 1ns / 1ps


module full_conv_tb();
    
reg reset = 1;
reg clk = 0;
reg resetflg = 0;

//always @(*) begin
//    #5;
//    clk = ~clk;
//    #5;
//    clk = ~clk;

//end
initial begin
    clk = 0;
    reset = 1;
    resetflg = 0;
    
    #5 clk = ~clk;
    #5 clk = ~clk;
    
    reset = 0;
    
    #5 clk = ~clk;
    #5 clk = ~clk;
    
    reset = 1;
    resetflg = 1;
    
    
    forever #5 clk = ~clk;
end

parameter N = 7, stride = 5, n = 5, im = 28, img = im + (stride-1);

logic [N:0] ker11[stride-1:0][stride-1:0];
logic [N:0] ker2[stride-1:0][stride-1:0];
logic [N:0] ker3[stride-1:0][stride-1:0];
logic [N:0] ker4[stride-1:0][stride-1:0];
logic [N:0] ker5[stride-1:0][stride-1:0];
logic [N:0] ker6[stride-1:0][stride-1:0];


logic [2*N+1:0] out11 [0:(im-1)];
logic [2*N+1:0] out2 [0:(im-1)];
logic [2*N+1:0] out3 [0:(im-1)];
logic [2*N+1:0] out4 [0:(im-1)];
logic [2*N+1:0] out5 [0:(im-1)];
logic [2*N+1:0] out6 [0:(im-1)];


reg [N:0] data;
reg data_valid;
wire data_request;
wire finish;
wire valid;

full_conv #(N, stride, n, im, img) full_conv_ut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .data_valid(data_valid),
        .ker1(ker11),
//        .ker2(ker2),
//        .ker3(ker3),
//        .ker4(ker4),
//        .ker5(ker5),
//        .ker6(ker6),
        
        .data_request(data_request),
        .out1(out11),
//        .out2(out2),
//        .out3(out3),
//        .out4(out4),
//        .out5(out5),
//        .out6(out6),
        .finish(finish),
        .valid(valid)
);

integer i = 0;
//reg [N:0] i = 0;
integer j = 0;

integer k,k1 = 0;
initial begin
          for(k = 0; k < 5; k = k + 1) begin
            for(k1 = 0; k1 < 5; k1 = k1 + 1) begin
                ker11[k][k1] = 1;
            end
          end
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
end

always @(posedge clk) begin
    if(resetflg == 1) begin
//        while(i < 1024) begin
            data_valid = 0;
            if(j%16 == 0) begin
                data = i;
                i = i + 1;
                data_valid = 1;
            end
            j = j + 1;
//        end
    end
end    


    
endmodule
