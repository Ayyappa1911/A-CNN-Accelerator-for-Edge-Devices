`timescale 1ns / 1ps

module full_conv_top_tb();

//module full_conv_top(input clk, output out);

reg clk = 0;
wire [15:0] out1, out2, out3, out4, out5, out6;


full_conv_top  full_conv_top_ut (
        .clk(clk),
        .ou1(out1),
        .ou2(out2),
        .ou3(out3),
        .ou4(out4),
        .ou5(out5),
        .ou6(out6)
        );
        
initial begin

forever #5 clk = ~ clk;

end

endmodule
