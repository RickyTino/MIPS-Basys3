module ReadManage (
	input wire [15:0] addr,
	input wire [31:0] ramrd, iord,
	output reg [31:0] memrd
);
	reg flag;
	wire [31:0] rd;
	
	always @(*) begin
		if(addr[15:12] == 4'h1)     flag = 0;
		else if(addr[15:8] == 8'hff) flag = 1;
	end
	
	Mux2 #(32) readsrc(
		.ctrl (flag),
		.in0  (ramrd),
		.in1  (iord),
		.out  (rd)
	);
	
	always @(*) memrd = rd;
	
endmodule