
//module conv_axi4_lite_slave#(
//    parameter N = 15, stride = 5, n = 5, im = 28, img = im + (stride-1)
//)(
            
//    input             clk,
//    input             reset,
//	input             axi_awvalid,
//	output reg        axi_awready,
//	input      [31:0] axi_awaddr,
//	input      [ 2:0] axi_awprot,

//	input             axi_wvalid,
//	output reg        axi_wready,
//	input      [31:0] axi_wdata,
//	input      [ 3:0] axi_wstrb,

//	output reg        axi_bvalid,
//	input             axi_bready,

//	input             axi_arvalid,
//	output reg        axi_arready,
//	input      [31:0] axi_araddr,
//	input      [ 2:0] axi_arprot,

//	output reg        axi_rvalid,
//	input             axi_rready,
//	output reg [31:0] axi_rdata
	
////	output [31:0] out10
	
//);

////reg data_valid_in;
////reg cipherkey_valid_in;

////reg [KEY_L-1:0] cipher_key;
////reg [DATA_W-1:0] plain_text; 

////wire valid_out;
////wire [DATA_W-1:0] cipher_text;
////wire [KEY_L-1:0] cipher_key_out;

//reg conv_reset = 1;
//reg [N:0] ker1[stride-1:0][stride-1:0];

//wire [N:0]out1[0:(im-1)];

//reg [N:0] data;
//reg data_valid;
//wire data_request;
//wire finish;
//wire valid;
//full_conv #(N, stride, n, im, img) full_conv_ut (
//        .clk(clk),
//        .reset(reset & conv_reset),
//        .data(data),
//        .data_valid(data_valid),
//        .ker1(ker1),
//        .ker2(),
//        .ker3(),
//        .ker4(),
//        .ker5(),
//        .ker6(),
        
//        .data_request(data_request),
//        .out1(out1),
//        .out2(),
//        .out3(),
//        .out4(),
//        .out5(),
//        .out6(),
//        .finish(finish),
//        .valid(valid)
//);
	
////assign out10 = out1[0];
//integer k,k1,i;

//always @(posedge clk or negedge reset) begin

//    if(!reset) begin
//        axi_wready   = 0;
//        axi_awready  = 0;
//        axi_arready  = 0;  
//        axi_bvalid   = 0;
//        axi_rvalid   = 0;
//        axi_rdata    = 0;
        
//        i = 1;
//        for(k = 0 ; k < stride; k = k + 1) begin
//            for(k1 = 0 ; k1 < stride; k1 = k1 + 1) begin
//                ker1[k][k1] = i;
////                $display("%d",i);
////                i = i + 1;
//            end
//        end
//    end
//    else begin
//        axi_awready = 0;
//        axi_arready = 0;
//        axi_bvalid  = 0;
//        axi_rvalid  = 0;
//        axi_rdata   = 0;
//        conv_reset  = 1;
    
//        axi_wready = data_request;
//        data = 0;
//        data_valid = 0;
        
//        if(axi_wready) begin
//            axi_awready = 1;
//        end
            
//        if(axi_awvalid && axi_wready) begin
         
//            if(axi_awaddr[3:0] == 4'b0000) begin
//                conv_reset = 0;
//            end
//            else begin
//                conv_reset = 1;
//                data = axi_wdata;
//                data_valid = axi_wvalid;
//            end
//        end
    
//        if(axi_bready) begin
//            axi_bvalid = 1;
//            axi_wready = 0;
//            axi_awready = 0;
//        end
    
//    end
    
////    if(axi_arvalid && valid_out) begin
    
////       axi_arready = 1;
	
////	   if(axi_araddr[31:28] == 4'b0000) begin
////	       conv_reset = 0;
//////		  key_read = axi_araddr[7:0];
////	   end
////	   else begin
//////	       key_read = 8'b11111111;
////	   end
	
////        axi_rvalid = 1;
//////        if(key_read == 8'b0000_0000) axi_rdata = cipher_key_out[127:96];
//////        else if(key_read == 8'b0000_0100) axi_rdata = cipher_key_out[95:64];
//////        else if(key_read == 8'b0000_1000) axi_rdata = cipher_key_out[63:32];
//////        else if(key_read == 8'b0000_1100) axi_rdata = cipher_key_out[31:0];
    
//////        else if(key_read == 8'b0001_0000) axi_rdata = cipher_text[127:96];
//////        else if(key_read == 8'b0001_0100) axi_rdata = cipher_text[95:64];
//////        else if(key_read == 8'b0001_1000) axi_rdata = cipher_text[63:32];
//////        else if(key_read == 8'b0001_1100) axi_rdata = cipher_text[31:0];
////    end 
    
//end

//endmodule