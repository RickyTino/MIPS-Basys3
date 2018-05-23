module SoC (
	input  wire         clk, reset,
	input  wire  [15:0] switch,      
	input  wire  [3 :0] keys,  
	output wire  [3 :0] an,
	output wire  [7 :0] ca,
	output wire  [15:0] led
);
	
	/*
	module IOComponent (
	input wire         clk, iowr,
	input wire  [15:0] switch,      
	input wire  [3 :0] keys,        
	input wire  [15:0] addr,        
	input wire  [31:0] writedata,   
	output reg  [31:0] readdata,    
	output reg  [3 :0] an,       
	output reg  [7 :0] ca,
	output reg  [15:0] led
);
	*/
	wire memwr, worb, rst;
	wire [9:0]  romaddr;
	wire [15:0] instaddr, memaddr;
	wire [31:0] romrd, memrd, memwd, ramrd, iord;
	
	assign rst = reset;
	assign mclk = clk;
	assign romaddr = instaddr[11:2];
	
	//Clock Division
	/*
	parameter T = 10 - 1; //100MHz -> 10MHz:
	wire mclk = clkcnt[3];	
	reg [9:0] clkcnt = 0;

	always @(posedge clk)
        clkcnt <= (clkcnt == T)? 32'd0 : clkcnt + 32'd1;
	*/
	
	Processor cpu (
		.clk      (mclk),
		.reset    (rst),
		.inst     (romrd),
		.memrd    (memrd),
		.memwr    (memwr),
		.memwd    (memwd),
		.worb     (worb),
		.instaddr (instaddr),
		.memaddr  (memaddr)
	);
	
	InstMem rom (
		.addr (romaddr),
		.data (romrd)
	);
	
	DataMem ram (
		.clk     (mclk),
		.we      (memwr),
		.worb    (worb),
		.addr    (memaddr),
		.indata  (memwd),
		.outdata (ramrd) 
	);
	
	IOComponent ioc (
		.clk       (mclk),
		.reset     (rst),
		.iowr      (memwr),
		.switch    (switch),
		.keys      (keys),
		.addr      (memaddr),
		.writedata (memwd),
		.readdata  (iord),
		.an        (an),
		.ca        (ca),
		.led       (led)
	);
	
	ReadManage rm (
		.addr  (memaddr),
		.ramrd (ramrd),
		.iord  (iord),
		.memrd (memrd)
	);
	
endmodule
	
	