module ALU (
	input  wire [31:0]  a,b,
	input  wire [4:0]   aluctrl, shamt,
	output reg  [31:0]  aluout,
	output reg     		trans
);	
	//AluCtrl Parameters
	parameter ADD   = 5'b00001;
	parameter SUB   = 5'b00010;
	parameter AND   = 5'b00011;
	parameter OR    = 5'b00100;
	parameter NOR   = 5'b00101;
	parameter XOR   = 5'b00110;
	parameter SLL   = 5'b00111;
	parameter SLLV  = 5'b01000;
	parameter SRA   = 5'b01001;
	parameter SRAV  = 5'b01010;
	parameter SRL   = 5'b01011;
	parameter SLT   = 5'b01100;
	parameter SLTU  = 5'b01101;
	parameter JR    = 5'b01110;
	parameter ADDI  = 5'b10000;
	parameter ANDI  = 5'b10001;
	parameter ORI   = 5'b10010;
	parameter XORI  = 5'b10011;
	parameter SLTI  = 5'b10100;                 
	parameter SLTIU = 5'b10101;
	parameter BGTZ  = 5'b10110;
	parameter BLTZ  = 5'b10111;
	parameter BEQ   = 5'b11000;
	parameter BNE   = 5'b11001;
	parameter LB    = 5'b11010;
	parameter LW    = 5'b11011;
	parameter SB    = 5'b11100;
	parameter SW    = 5'b11101;
	
	wire [31:0] sll, sllv, sra, srav, srl;
	
	ALUShift shifter (
		.a     (a),
		.b     (b),
		.shamt (shamt),
		.sll   (sll),
		.sllv  (sllv),
		.sra   (sra),
		.srav  (srav),
		.srl   (srl)
	);
	
	always@(*) begin
		aluout <= 32'b0;
		trans  <= 0;
		case (aluctrl)
			//R-Type
			ADD:   aluout <= a + b;
			SUB:   aluout <= a - b;
			AND:   aluout <= a & b;
			OR:    aluout <= a | b;
			NOR:   aluout <= ~(a | b);
			XOR:   aluout <= (~a & b) | (~b & a);
			SLL:   aluout <= sll;
			SLLV:  aluout <= sllv;
			SRA:   aluout <= sra;
			SRAV:  aluout <= srav;
			SRL:   aluout <= srl;
			SLT:   aluout <= ($signed(a) < $signed(b))?  32'b1: 32'b0;
			SLTU:  aluout <= ($unsigned(a) < $unsigned(b))?  32'b1: 32'b0;
			JR:    aluout <= a;
			//I-Type
			ADDI:  aluout <= a + b;
			ANDI:  aluout <= a & b;
			ORI:   aluout <= a | b;
			XORI:  aluout <= (~a & b) | (~b & a);
			SLTI:  aluout <= ($signed(a) < $signed(b))?  32'b1: 32'b0;
			SLTIU: aluout <= ($unsigned(a) < $unsigned(b))?  32'b1: 32'b0;
			//Transition
			BGTZ:  trans <= ($signed(a) > $signed(b)) ? 1'b1: 1'b0;
			BLTZ:  trans <= ($signed(a) < $signed(b)) ? 1'b1: 1'b0;
			BEQ:   trans <= (a == b)? 1'b1: 1'b0;
			BNE:   trans <= (a != b)? 1'b1: 1'b0;
			//Memory Access
			LB:    aluout <= a + b;
			LW:    aluout <= a + b;
			SB:    aluout <= a + b;
			SW:    aluout <= a + b;	
		endcase
	end
	
endmodule