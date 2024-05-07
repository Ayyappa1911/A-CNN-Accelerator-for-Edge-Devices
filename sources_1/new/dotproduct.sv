
module dotpdt #(parameter N = 7,parameter stride = 3,parameter n = 3)(
                input clk,
                input reset,
                input inp_valid,
                input [2:0] ker_len,
                input [N:0] Arr1 [stride-1:0],
                input [N:0] Arr2 [stride-1:0],
                output reg [2*N+1:0] dp = 0,
                output reg valid = 0
            );

logic [N:0] arr1 [stride-1:0];
logic [N:0] arr2 [stride-1:0];

wire [2*N+1:0] dpin;
reg [2*N+1:0] dp1;

reg [7:0] accflg=0;

reg [7:0] i,j;

iiitb_sysarr #(N,n)sysarr(
             .clk(clk),
             .arr1(arr1),
             .arr2(arr2),
             .ker_len(ker_len),
             .out(dpin)
            );

always @(posedge clk or negedge reset) begin

    if(!reset) begin
        valid = 0;
        accflg = -1;
        dp = 0;
        for(j = 0; j < n; j = j + 1) begin
            arr1[j] = 0;
            arr2[j] = 0;
	    end
    end
    else if(reset) begin
//        if(accflg == n + n + 2) begin
//            accflg = n + 2;
//            dp = 0;
//            valid = 0;
//        end
        if(accflg == ker_len + ker_len + 2) begin
            accflg = ker_len + 2;
            dp = 0;
            valid = 0;
        end

        if(!inp_valid) begin
           for(j = 0; j < n; j = j + 1) begin
             arr1[j] = 0;
             arr2[j] = 0;
	       end
        end
        else if(inp_valid)begin
            for(j = 0; j < n; j = j + 1) begin
             arr1[j] = Arr1[j];
             arr2[j] = Arr2[j];
	       end
        end

        if(accflg >= ker_len + 2 && accflg <= ker_len + ker_len + 1) begin
            if(dpin >= 0 || dpin < 0) begin 
                dp = dp + dpin;
            end
            
            if(accflg == ker_len + ker_len + 1) begin
                if(dp >= 0 || dp <0) begin
                    valid = 1;
                end
            end
        end
    
        accflg = accflg + 1;
//        $display("flg = %d dpin = %d dp = %d",flg,twos(dpin),twos(dp));
//        $display("accflg = %d",accflg);
    end
end

endmodule

