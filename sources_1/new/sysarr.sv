
module iiitb_sysarr #(parameter N = 7,parameter odr = 3)(
                    input clk,
                    output reg [2*N+1:0]out,
                    input [2:0] ker_len,
                    input [N:0] arr1 [odr-1:0],
                    input [N:0] arr2 [odr-1:0]
               );

(* dont_touch = "yes" *) logic [N:0]A[odr:0][odr:0];
(* dont_touch = "yes" *) logic [N:0]B[odr:0][odr:0];
(* dont_touch = "yes" *) logic [2*N+1:0]C[odr:0];

genvar row,col;
generate
	for(row = 0; row < odr; row = row + 1) begin
		for(col = 0; col < odr; col = col + 1) begin
			if(row == col) begin
				PE #(N)prosele(
					.clk(clk),
					.a(A[row][col]),
					.b(B[row][col]),
					.c(C[row]),
					.out(C[row+1])
				);
			end
			else if(row > col) begin
				delay #(N)dela(
					.clk(clk),
					.a(A[row][col]),
					.a1(A[row][col+1])
				);
			end
			else begin
			   delay #(N)delb(
					.clk(clk),
					.a(B[row][col]),
					.a1(B[row+1][col])
				);
			end
		end	
	end
endgenerate

reg [7:0] i,j,i1,j1;

always @(negedge clk) begin
	C[0] = 0;
	for(j = 0; j < odr; j = j + 1) begin
            A[j][0] = arr1[odr-1-j];
            B[0][j] = arr2[odr-1-j];
	end
    out = C[ker_len];
end

endmodule 


module PE #(parameter N = 7)(a,b,c,out,clk);

input [N:0] a,b;
input [2*N+1 :0] c; 
input clk;

output reg [2*N+1 :0] out;

always @(negedge clk)
begin
    out <= c+a*b;
end

endmodule


module delay #(parameter N = 15)(a,a1,clk);

input [N:0] a;
input clk;
output reg [N:0] a1;

always @(negedge clk)
begin
    a1 <= a;
end

endmodule