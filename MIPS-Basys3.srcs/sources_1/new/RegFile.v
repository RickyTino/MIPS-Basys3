 module RegFile (
	input  wire          clk, regwr, spen,
	input  wire [4:0]    rr1, rr2, wr,
	input  wire [31:0]   wd,
	input  wire [15:0]   pc,
	output wire [31:0]   rd1, rd2
);

	parameter sp = 29;
	parameter ra = 31;
	
	reg [31:0] RAM [31:0];
	
	always @(posedge clk) begin
		if (regwr) RAM[wr] <= wd;
	    if (spen) RAM[ra] <= {16'b0, pc + 4};
	end
	
	assign rd1 = rr1 ? RAM[rr1]: 0;
	assign rd2 = rr2 ? RAM[rr2]: 0;
	
endmodule