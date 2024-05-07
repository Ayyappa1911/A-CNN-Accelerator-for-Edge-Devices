`timescale 1ns / 1ps


module axi4_lite_slave_decoder #(
            parameter AXI_TEST = 0,
	        parameter VERBOSE = 0
        )(
            
           input             clk,
           input             reset,
	       input             axi_awvalid,
	       output reg        axi_awready,
	       input      [31:0] axi_awaddr,
	       input      [ 2:0] axi_awprot,

	       input             axi_wvalid,
	       output reg        axi_wready,
	       input      [31:0] axi_wdata,
	       input      [ 3:0] axi_wstrb,

	       output reg        axi_bvalid,
	       input             axi_bready,

	       input             axi_arvalid,
	       output reg        axi_arready,
	       input      [31:0] axi_araddr,
	       input      [ 2:0] axi_arprot,

	       output reg        axi_rvalid,
	       input             axi_rready,
	       output reg [31:0] axi_rdata,

	       wire        tests_passed
	       
//	       output [127:0] cipher_txt,
//	       output [127:0] cipher_txt1
	       
//	       input [3:0] slave_dec
        );

wire clk_out96;
clk_wiz_0 clk_wizz
   (
    // Clock out ports
    .clk_out1(clk_out96),     // output clk_out1
    // Status and control signals
    .reset(!reset), // input reset
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1(clk));
        
        
        reg [3:0] slave_dec;

// Data signals for slave0
        reg mem_axi_awvalid0;
        wire mem_axi_awready0;
        reg [31:0] mem_axi_awaddr0;
        reg [2:0] mem_axi_awprot0;
        
        reg mem_axi_wvalid0;
        wire mem_axi_wready0;
        reg [31:0] mem_axi_wdata0;
	    reg [ 3:0] mem_axi_wstrb0;
	    
	    wire mem_axi_bvalid0;
	    reg mem_axi_bready0;
	    
	    reg mem_axi_arvalid0;
	    wire mem_axi_arready0;
	    reg [31:0] mem_axi_araddr0;
	    reg [ 2:0] mem_axi_arprot0;
	    
	    wire mem_axi_rvalid0;
	    reg mem_axi_rready0;
	    wire [31:0] mem_axi_rdata0;
	    
	    
// data signals for slave1
	    
	    reg axi_awvalid1;
        wire axi_awready1;
        reg [31:0] axi_awaddr1;
        reg [2:0] axi_awprot1;
        
        reg axi_wvalid1;
        wire axi_wready1;
        reg [31:0] axi_wdata1;
	    reg [ 3:0] axi_wstrb1;
	    
	    wire axi_bvalid1;
	    reg axi_bready1;
	    
	    reg axi_arvalid1;
	    wire axi_arready1;
	    reg [31:0] axi_araddr1;
	    reg [ 2:0] axi_arprot1;
	    
	    wire axi_rvalid1;
	    reg axi_rready1;
	    wire [31:0] axi_rdata1;
	    
// data signals for slave2
	    
//	    reg axi_awvalid2;
//        wire axi_awready2;
//        reg [31:0] axi_awaddr2;
//        reg [2:0] axi_awprot2;
        
//        reg axi_wvalid2;
//        wire axi_wready2;
//        reg [31:0] axi_wdata2;
//	    reg [ 3:0] axi_wstrb2;
	    
//	    wire axi_bvalid2;
//	    reg axi_bready2;
	    
//	    reg axi_arvalid2;
//	    wire axi_arready2;
//	    reg [31:0] axi_araddr2;
//	    reg [ 2:0] axi_arprot2;
	    
//	    wire axi_rvalid2;
//	    reg axi_rready2;
//	    wire [31:0] axi_rdata2;
	    
	    
	    
// Slave 0    

	axi4_memory #(
//		.AXI_TEST (AXI_TEST),
//		.VERBOSE  (VERBOSE)
	) mem (
		.clk             (clk             ),
		.mem_axi_awvalid (mem_axi_awvalid0 ),
		.mem_axi_awready (mem_axi_awready0 ),
		.mem_axi_awaddr  (mem_axi_awaddr0  ),
		.mem_axi_awprot  (mem_axi_awprot0  ),

		.mem_axi_wvalid  (mem_axi_wvalid0  ),
		.mem_axi_wready  (mem_axi_wready0  ),
		.mem_axi_wdata   (mem_axi_wdata0   ),
		.mem_axi_wstrb   (mem_axi_wstrb0   ),

		.mem_axi_bvalid  (mem_axi_bvalid0  ),
		.mem_axi_bready  (mem_axi_bready0  ),

		.mem_axi_arvalid (mem_axi_arvalid0 ),
		.mem_axi_arready (mem_axi_arready0 ),
		.mem_axi_araddr  (mem_axi_araddr0  ),
		.mem_axi_arprot  (mem_axi_arprot0  ),

		.mem_axi_rvalid  (mem_axi_rvalid0  ),
		.mem_axi_rready  (mem_axi_rready0  ),
		.mem_axi_rdata   (mem_axi_rdata0   ),

		.tests_passed    (tests_passed    )
	);
	
// Slave 1
	
(* keep_hierarchy = "yes" *) conv_axi4_lite_slave convolution(
            
    .clk(clk),
    .reset(reset),
	
	.axi_awvalid(axi_awvalid1),
	.axi_awready(axi_awready1),
	.axi_awaddr(axi_awaddr1),
	.axi_awprot(axi_awprot1),

	.axi_wvalid(axi_wvalid1),
	.axi_wready(axi_wready1),
	.axi_wdata(axi_wdata1),
	.axi_wstrb(axi_wstrb1),

	.axi_bvalid(axi_bvalid1),
	.axi_bready(axi_bready1),

	.axi_arvalid(axi_arvalid1),
	.axi_arready(axi_arready1),
	.axi_araddr(axi_araddr1),
	.axi_arprot(axi_arprot1),

	.axi_rvalid(axi_rvalid1),
	.axi_rready(axi_rready1),
	.axi_rdata(axi_rdata1)
	
//	.cipher_txt(cipher_txt)
);

// Slave 2


//decryption_axi4_lite_slave decryptor(
            
//    .clk(clk),
//    .reset(reset),
	
//	.axi_awvalid(axi_awvalid2),
//	.axi_awready(axi_awready2),
//	.axi_awaddr(axi_awaddr2),
//	.axi_awprot(axi_awprot2),

//	.axi_wvalid(axi_wvalid2),
//	.axi_wready(axi_wready2),
//	.axi_wdata(axi_wdata2),
//	.axi_wstrb(axi_wstrb2),

//	.axi_bvalid(axi_bvalid2),
//	.axi_bready(axi_bready2),

//	.axi_arvalid(axi_arvalid2),
//	.axi_arready(axi_arready2),
//	.axi_araddr(axi_araddr2),
//	.axi_arprot(axi_arprot2),

//	.axi_rvalid(axi_rvalid2),
//	.axi_rready(axi_rready2),
//	.axi_rdata(axi_rdata2),
	
//	.cipher_txt(cipher_txt2)
//);
        
        
 always @(*) begin
 
    
 
    if(axi_araddr[31:28] == 0) begin
        slave_dec = 0;
    end
    else begin
        slave_dec = axi_araddr[31:28];
    end
    
    mem_axi_awvalid0 = 0;
    mem_axi_awaddr0 = 0;
    mem_axi_awprot0 = 0;
        
    mem_axi_wvalid0 = 0;
    mem_axi_wdata0 = 0;
	mem_axi_wstrb0 = 0;
	    

    mem_axi_bready0 = 0;
	    
	mem_axi_arvalid0 = 0;
	mem_axi_araddr0 = 0;
	mem_axi_arprot0 = 0;

    mem_axi_rready0 = 0;
    

    
    axi_awvalid1 = 0;
    axi_awaddr1 = 0;
    axi_awprot1 = 0;
        
    axi_wvalid1 = 0;
    axi_wdata1 = 0;
	axi_wstrb1 = 0;
	    
    axi_bready1 = 0;
	    
	axi_arvalid1 = 0;
	axi_araddr1 = 0;
	axi_arprot1 = 0;
	    
    axi_rready1= 0;
    
    
    
//    axi_awvalid2 = 0;
//    axi_awaddr2 = 0;
//    axi_awprot2 = 0;
        
//    axi_wvalid2 = 0;
//    axi_wdata2 = 0;
//	axi_wstrb2 = 0;
	    
//    axi_bready2 = 0;
	    
//	axi_arvalid2 = 0;
//	axi_araddr2 = 0;
//	axi_arprot2 = 0;
	    
//    axi_rready2= 0;

 
    if( slave_dec == 4'b0000) begin
    
        mem_axi_awvalid0 = axi_awvalid;
        axi_awready = mem_axi_awready0;
        mem_axi_awaddr0 = axi_awaddr;
        mem_axi_awprot0 = axi_awprot;
        
        mem_axi_wvalid0 = axi_wvalid;
        axi_wready = mem_axi_wready0;
        mem_axi_wdata0 = axi_wdata;
   	    mem_axi_wstrb0 = axi_wstrb;
	    
	    axi_bvalid = mem_axi_bvalid0;
        mem_axi_bready0 = axi_bready;
	    
	    mem_axi_arvalid0 = axi_arvalid;
	    axi_arready = mem_axi_arready0;
	    mem_axi_araddr0 = axi_araddr;
	    mem_axi_arprot0 = axi_arprot;
	    
	    axi_rvalid = mem_axi_rvalid0;
        mem_axi_rready0 = axi_rready;
	    axi_rdata = mem_axi_rdata0;
    
    end
    
    else if(slave_dec == 4'b0001) begin
    
        axi_awvalid1 = axi_awvalid;
        axi_awready = axi_awready1;
        axi_awaddr1 = axi_awaddr;
        axi_awprot1 = axi_awprot;
        
        axi_wvalid1 = axi_wvalid;
        axi_wready = axi_wready1;
        axi_wdata1 = axi_wdata;
   	    axi_wstrb1 = axi_wstrb;
	    
	    axi_bvalid = axi_bvalid1;
        axi_bready1 = axi_bready;
	    
	    axi_arvalid1 = axi_arvalid;
	    axi_arready = axi_arready1;
	    axi_araddr1 = axi_araddr;
	    axi_arprot1 = axi_arprot;
	    
	    axi_rvalid = axi_rvalid1;
        axi_rready1 = axi_rready;
	    axi_rdata = axi_rdata1;
    
    end
    
//    else if(slave_dec == 4'b0010) begin
    
//        axi_awvalid2 = axi_awvalid;
//        axi_awready = axi_awready2;
//        axi_awaddr2 = axi_awaddr;
//        axi_awprot2 = axi_awprot;
        
//        axi_wvalid2 = axi_wvalid;
//        axi_wready = axi_wready2;
//        axi_wdata2 = axi_wdata;
//   	    axi_wstrb2 = axi_wstrb;
	    
//	    axi_bvalid = axi_bvalid2;
//        axi_bready2 = axi_bready;
	    
//	    axi_arvalid2 = axi_arvalid;
//	    axi_arready = axi_arready2;
//	    axi_araddr2 = axi_araddr;
//	    axi_arprot2 = axi_arprot;
	    
//	    axi_rvalid = axi_rvalid2;
//        axi_rready2 = axi_rready;
//	    axi_rdata = axi_rdata2;
    
//    end
     
 end

endmodule
