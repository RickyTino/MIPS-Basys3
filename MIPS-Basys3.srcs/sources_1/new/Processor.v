module Processor (
	input  wire        clk, reset,
	input  wire [31:0] inst, memrd,
	output wire        worb, memwr,
	output wire [15:0] instaddr, memaddr,
	output wire [31:0] memwd
);
	
	//Controller
	wire       trans;
	wire       regdst, regwr;
	wire       memtoreg, spen;
	wire [1:0] alusrc, pcsrc;
	wire [4:0] aluctrl, r1, r2, r3, shamt;
	wire [5:0]  op, funct;
	wire [15:0] imme, targ;
	
	assign op    = inst[31:26];
	assign r1    = inst[25:21];
	assign r2    = inst[20:16];
	assign r3    = inst[15:11];
	assign shamt = inst[10:6];
	assign funct = inst[5:0];
	assign imme  = inst[15:0];
	assign targ  = imme << 2;
	
	ControlUnit cu (
		.op       (op),
		.funct    (funct),
		.trans    (trans),
		.regdst   (regdst),
		.regwr    (regwr),
		.aluctrl  (aluctrl),
		.memwrite (memwr),
		.memtoreg (memtoreg),
		.spen     (spen),
		.worb     (worb),
		.alusrc   (alusrc),
		.pcsrc    (pcsrc)
	);
	
	//Program Counter
	wire [15:0] nextpc, nowpc, pcplus4;
	wire [31:0] aluout;
	
	assign instaddr = nowpc;
	assign pcplus4  = nowpc + 16'h4;
	assign targ     = imme << 2;
	
	ProgramCounter pc (
		.clk   (clk),
		.reset (reset),
		.idat  (nextpc),
		.odat  (nowpc)
	);
	
	Mux4 #(16) pcsource (
		.ctrl (pcsrc),
		.in0  (pcplus4),
		.in1  (targ),
		.in2  (pcplus4 + targ),
		.in3  (aluout[15:0]),
		.out  (nextpc)
	);
	
	//Reg File
	wire [4:0]  wr;
	wire [31:0] wd, rd1, rd2;
	
	assign memwd = rd2;
	
	RegFile rf (
		.clk   (clk),
		.regwr (regwr),
		.spen  (spen),
		.rr1   (r1),
		.rr2   (r2),
		.wr    (wr),
		.wd    (wd),
		.pc    (nowpc),
		.rd1   (rd1),
		.rd2   (rd2)
	);
	
	Mux2 #(5) rdst (
		.ctrl (regdst),
		.in0  (r2),
		.in1  (r3),
		.out  (wr)
	);
	
	Mux2 #(32) mtor (
		.ctrl (memtoreg),
		.in0  (aluout),
		.in1  (memrd),
		.out  (wd)
	);
	
	//ALU
	wire [31:0] alua, alub;
	wire [31:0] seimme, zeimme;
	
	assign alua    = rd1;
	assign memaddr = aluout;
	
	ALU alunit(
		.a       (alua),
		.b       (alub),
		.aluctrl (aluctrl),
		.shamt   (shamt),
		.trans   (trans),
		.aluout  (aluout)
	);
	
	SignExtend sext (
		.in  (imme),
		.out (seimme)
	);
	
	ZeroExtend zext (
		.in  (imme),
		.out (zeimme)
	);
	
	Mux4 #(32) alusource (
		.ctrl (alusrc),
		.in0  (rd2),
		.in1  (seimme),
		.in2  (zeimme),
		.in3  (      ),
		.out  (alub)
	);

endmodule	