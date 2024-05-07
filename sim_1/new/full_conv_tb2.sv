`timescale 1ns / 1ps


module full_conv_tb2();

    
//module full_conv#(parameter N = 7, nok = 6, stride = 5, n = 5, im = 28, img = im + (stride-1))(
//        input clk,
//        input reset,
//        input [N:0] data,
//        input data_valid,
////        input [N:0]ker1[stride-1:0][stride-1:0],
////        input [N:0]ker2[stride-1:0][stride-1:0],
////        input [N:0]ker3[stride-1:0][stride-1:0],
////        input [N:0]ker4[stride-1:0][stride-1:0],
////        input [N:0]ker5[stride-1:0][stride-1:0],
////        input [N:0]ker6[stride-1:0][stride-1:0],
//        input [N:0] ker[0:nok-1][0:stride*stride-1],
//        input [11:0] img_len,
//        input [2:0] ker_len,
        
//        output reg data_request,
////        output [2*N+1:0]out1,
////        output [2*N+1:0]out2,
////        output [2*N+1:0]out3,
////        output [2*N+1:0]out4,
////        output [2*N+1:0]out5,
////        output [2*N+1:0]out6,
//        output [2*N+1:0]out[0:nok-1],
        
//        output reg finish,
//        output valid,
//        output reg [11:0] valid_idx,
//        output reg conv_fin
//);
    


parameter N = 7, nok = 3, stride = 5, n = 5, im = 28, img = im + (stride-1);

logic clk = 0;
logic reset = 1;

logic [N:0] data;
logic data_valid;
logic [N:0] ker[0:nok-1][0:stride*stride-1];
logic [11:0]img_len;
logic [2:0] ker_len;
logic data_request;

logic [2*N+1:0]out[0:nok-1];
        
logic finish;
logic valid;
logic [11:0] valid_idx;
logic conv_fin;

full_conv #(N, nok, stride, n, im, img) dut_test (
    .clk(clk),
    .reset(reset),
    .data(data),
    .data_valid(data_valid),
    .ker(ker),
    .img_len(img_len),
    .ker_len(ker_len),
    .data_request(data_request),
    .out(out),
    .finish(finish),
    .valid(valid),
    .valid_idx(valid_idx),
    .conv_fin(conv_fin)
);

initial begin

clk = 0;

forever #5 clk = ~clk;

end

logic [N:0] A[0:img*img - 1]; 
logic [2*N+1:0] Aout1[0:30*30-1];
logic [2*N+1:0] Aout2[0:30*30-1];
logic [2*N+1:0] Aout3[0:30*30-1];

int i = 0;
int i1 = 0;

logic resetflg = 0;

initial begin

img_len = 32;
ker_len = 3;



ker[0][0]  = 1; ker[0][1]  = 1; ker[0][2]  = 1; ker[0][3]  = 0; ker[0][4]  = 0; 
ker[0][5]  = 1; ker[0][6]  = 1; ker[0][7]  = 1; ker[0][8]  = 0; ker[0][9]  = 0; 
ker[0][10] = 1; ker[0][11] = 1; ker[0][12] = 1; ker[0][13] = 0; ker[0][14] = 0; 
ker[0][15] = 0; ker[0][16] = 0; ker[0][17] = 0; ker[0][18] = 0; ker[0][19] = 0; 
ker[0][20] = 0; ker[0][21] = 0; ker[0][22] = 0; ker[0][23] = 0; ker[0][24] = 0; 


ker[1][0]  = 1; ker[1][1]  = 2; ker[1][2]  = 1; ker[1][3]  = 0; ker[1][4]  = 0; 
ker[1][5]  = 2; ker[1][6]  = 4; ker[1][7]  = 2; ker[1][8]  = 0; ker[1][9]  = 0; 
ker[1][10] = 1; ker[1][11] = 2; ker[1][12] = 1; ker[1][13] = 0; ker[1][14] = 0; 
ker[1][15] = 0; ker[1][16] = 0; ker[1][17] = 0; ker[1][18] = 0; ker[1][19] = 0; 
ker[1][20] = 0; ker[1][21] = 0; ker[1][22] = 0; ker[1][23] = 0; ker[1][24] = 0;


ker[2][0]  = 2; ker[2][1]  = 1; ker[2][2]  = 0; ker[2][3]  = -1; ker[2][4]  = -2; 
ker[2][5]  = 3; ker[2][6]  = 2; ker[2][7]  = 0; ker[2][8]  = -2; ker[2][9]  = -3; 
ker[2][10] = 4; ker[2][11] = 3; ker[2][12] = 0; ker[2][13] = -3; ker[2][14] = -4; 
ker[2][15] = 3; ker[2][16] = 2; ker[2][17] = 0; ker[2][18] = -2; ker[2][19] = -3; 
ker[2][20] = 2; ker[2][21] = 1; ker[2][22] = 0; ker[2][23] = -1; ker[2][24] = -2;


//ker[0][0]  = 1; ker[0][1]  = 1; ker[0][2]  = 1;  ker[0][3] = 0; ker[0][4] = 0;
//ker[0][5]  = 1; ker[0][6]  = 1; ker[0][5]  = 1;  ker[0][3] = 0; ker[0][4] = 0;
//ker[0][6]  = 1; ker[0][7]  = 1; ker[0][8]  = 1;  ker[0][3] = 0; ker[0][4] = 0;
//ker[0][6]  = 0; ker[0][7]  = 0; ker[0][8]  = 0;  ker[0][3] = 0; ker[0][4] = 0;
//ker[0][6]  = 0; ker[0][7]  = 0; ker[0][8]  = 0;  ker[0][3] = 0; ker[0][4] = 0;


//ker[1][0]  = 1; ker[1][1]  = 2; ker[1][2]  = 1; 
//ker[1][3]  = 2; ker[1][4]  = 4; ker[1][5]  = 2; 
//ker[1][6]  = 1; ker[1][7]  = 2; ker[1][8]  = 1; 


//ker[2][0]  = -1; ker[2][1]  = 0; ker[2][2]  = 1; 
//ker[2][3]  = -2; ker[2][4]  = 0; ker[2][5]  = 2; 
//ker[2][6] = -1; ker[2][7] = 0; ker[2][8] = 1; 


resetflg = 0;

reset = 0;

$readmemb("seven.txt",A);

i = 0;
i1 = -1;

reset = 1;

#20;

reset = 0;

#20;

reset = 1;
resetflg = 1;

//while(conv_fin == 0) begin
//    data_valid = 0;
//    @(data_request == 1) begin
//        data = A[i];
//        i = i + 1;
////        data_valid = 1;
//    end
    
//    if(valid) begin
//        Aout1[i1] = out[0];
//        Aout2[i1] = out[1];
//        Aout3[i1] = out[2]; 
        
//        i1 = i1 + 1;
//    end
    
//    // #9;
    
//end
            
//            if(!conv_fin) begin
//                cnt = cnt + 1;
//            end

//    $writememb("out_img32_ker5_1.txt",Aout1);
//    $writememb("out_img32_ker5_2.txt",Aout2);
//    $writememb("out_img32_ker5_3.txt",Aout3);


end


always @(posedge clk) begin

if(conv_fin == 0 && resetflg == 1) begin
    data_valid = 0;
    if (data_request == 1) begin
        data = A[i];
        i = i + 1;
        data_valid = 1;
    end
    
    
end
            
end

always @(negedge valid) begin
    
//if(valid) begin
    Aout1[i1] = out[0];
    Aout2[i1] = out[1];
    Aout3[i1] = out[2]; 
        
    i1 = i1 + 1;
//end    
   
end

//always @(negedge finish) begin
//    i1 = i1 + 1;
//end

initial begin

    @(posedge conv_fin) begin
        $writememb("out_img32_ker3_1.txt",Aout1);
        $writememb("out_img32_ker3_2.txt",Aout2);
        $writememb("out_img32_ker3_3.txt",Aout3);
    end

end

endmodule
