module ClockDivision (   //100MHz -> 1kHz
	input wire  iclk,
	output wire oclk
);
	/*
	reg[9:0] DivMHz, DivKHz, DivHz;
	always @(posedge clk100MHz) DivMHz <= (DivMHz == 1000)? 0 : DivMHz+1;
	wire  clk100KHz = DivMHz[9];
	always @(posedge clk100KHz) DivKHz <= (DivKHz == 1000)? 0 : DivKHz+1;
	wire  clk100Hz  = DivKHz[9];
	always @(posedge clk100Hz)  DivHz  <= (DivHz  ==  100)? 0 : DivHz+1;
	wire  clk1Hz  = DivHz[8];
	*/
	
	parameter T1 = 1000;
	parameter T2 = 100;
	reg[9:0] cnt1, cnt2;
	
	initial begin
		cnt1 = 10'b0;
		cnt2 = 10'b0;
	end
	
	always @(posedge iclk)
		cnt1 <= (cnt1 == T1 - 1)? 0 : cnt1+1;
		
	//%50: always @(posedge cnt1[6]) clk1 <= ~clk1;
//	wire  clk1 = (cnt1 > T1 / 2 - 1);
	wire  clk1 = cnt1[9];
	
	always @(posedge clk1)
		cnt2 <= (cnt2 == T2 - 1)? 0 : cnt2+1;
		
//	wire  clk2  = (cnt2 > T2 / 2 - 1);
	wire  clk2  = cnt2[6];
	
	assign oclk = clk2;

endmodule