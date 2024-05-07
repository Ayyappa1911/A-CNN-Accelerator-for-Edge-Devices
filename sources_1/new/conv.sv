
module conv #(parameter N = 7, parameter stride = 3, parameter n = 3, parameter im = 32,parameter img = im + (stride-1))(
                input clk,
//                input [N:0]ker[stride-1:0][stride-1:0],
//                input [N:0]array[0:(stride-1)][0:(img-1)],
//                input [N:0]array[0:(stride-1)][0:(stride-1)],
                input [N:0] array [stride-1:0],
                input [N:0] ker [stride-1:0],
                input reset,
//                input [11:0] img_len,
                input [2:0] ker_len,
                input inp_valid,
//                input [4:0] flg,
                
                output [2*N+1:0]out,
//                output reg finish = 0,
                output valid
//                output reg [N:0] valid_idx
            ); 

//reg flag = 1;


//logic [N:0] arr1 [stride-1:0];
//logic [N:0] arr2 [stride-1:0];

//reg [4:0] flg = -1;
wire [2*N+1:0]dpin;
//reg [9:0] j;
//reg [4:0] k1;

assign out = (valid) ? dpin : out;

//function integer twos(input [N:0] inp);
//    twos = inp;
//endfunction

//reg inp_valid = 0;

dotpdt #(N,stride,n) xyz (
             .clk(clk),
             .reset(reset),
             .inp_valid(inp_valid),
             .ker_len(ker_len),
             .Arr1(array),
             .Arr2(ker),
             .dp(dpin),
             .valid(valid)
            );

//always @(posedge clk or negedge reset) begin
//    if(!reset) begin       
//        flag = 0;
//        flg = 0;
//        finish = 0;
//        inp_valid = 0;
//        out = 0;
//        j = 0;
//        valid_idx = -1;
//    end
//    else begin
//        if(!flag) begin
//            if(flg < ker_len) begin
//                arr1 = ker[flg];
//                arr2 = ker[flg];

//                inp_valid = 1;
//            end
//            else begin
//                inp_valid = 0;
//            end
            
//            flg = flg + 1;
            
//            if(flg == ker_len) begin
//                flg = 0; 
//                j = j + 1;
//            end
            
//            if(valid == 1) begin
////                out = dpin;
////                valid_idx = j;
                
//                if(j == (img_len)-(ker_len-1) + 2) begin
//                   j = 0;
//                   finish = 1;    
//                   flag = 1;                
//                end
//            end
//        end
//    end
//end

endmodule
            