`timescale 1ns / 1ps



module conv_picorv32_tb();
    
reg clk = 0;

reg resetn = 0;

always 
#5 clk = ~clk;
 
 initial begin
        resetn = 1;
        #20;
        resetn = 0;
        #20;
        resetn = 1;
        
		repeat (100) @(posedge clk);
		resetn = 1;
	end
//reg resetn = 1;
//wire trap;
//wire trace_valid;
//wire [35:0] trace_data;

picorv32_axi_top wrap (
    .clk(clk),
    .resetn(resetn)
//    .resetn(resetn),
//    .trap(trap),
//    .trace_valid(trace_valid),
//    .trace_data(trace_data)
);


//initial begin

////    resetn = 0;

//end
    
    
//    module picorv32_wrapper #(
//	parameter AXI_TEST = 0,
//	parameter VERBOSE = 0
//) (
//	input clk,
//	input resetn,
//	output trap,
//	output trace_valid,
//	output [35:0] trace_data
//);
    
endmodule
