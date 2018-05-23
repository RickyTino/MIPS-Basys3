module ProgramCounter (
	input  wire        clk, reset,
	input  wire [15:0] idat,
	output reg  [15:0] odat
);
	
	initial odat = 16'h0000;
	always @(posedge clk) begin
		if(reset) odat <= 16'h0000;
		else odat <= idat;
	end
	
endmodule
		