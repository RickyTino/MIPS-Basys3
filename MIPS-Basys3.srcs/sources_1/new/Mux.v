module Mux2 #(parameter WIDTH = 32) (
	input  wire             ctrl,
	input  wire [WIDTH-1:0] in0, in1,
	output wire [WIDTH-1:0] out
);

	assign out = ctrl ? in1 : in0;
	
endmodule

module Mux4 #(parameter WIDTH = 32) (
	input  wire [1:0]   ctrl,
	input  wire [WIDTH-1:0] in0, in1, in2, in3,
	output reg [WIDTH-1:0] out
);
	
	always @(*) begin
		case(ctrl)
			2'b00: out <= in0;
			2'b01: out <= in1;
			2'b10: out <= in2;
			2'b11: out <= in3;
		endcase
	end
	
endmodule