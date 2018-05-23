module SignExtend (
	input wire [15:0] in,
	output wire [31:0] out
);

	assign out = in[15] ? {~(16'b0), in} : {16'b0, in};
	
endmodule 