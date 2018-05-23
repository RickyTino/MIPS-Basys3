module InstMem (
	input  wire [9:0]  addr,
	output reg  [31:0] data
);
	
	reg[31:0] ROM [1024:0];
	
	initial begin
		$readmemh("Rom.dat", ROM);
	end
	
	always @(*) data <= ROM[addr];
	
endmodule