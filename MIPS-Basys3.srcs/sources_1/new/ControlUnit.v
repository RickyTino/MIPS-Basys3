module ControlUnit (
	input wire [5:0] op, funct,
	input wire       trans,
	output reg       regdst, regwr, worb,
	output reg       memwrite, memtoreg, spen, 
	output reg [1:0] alusrc, pcsrc,
	output reg [4:0] aluctrl
);
	
	//OP Parameters
	parameter RTYPE  = 6'b000000;
	parameter ADDI   = 6'b001000;
	parameter ANDI   = 6'b001100;
	parameter ORI    = 6'b001101;
	parameter XORI   = 6'b001110;
	parameter SLTI   = 6'b001010;                 
	parameter SLTIU  = 6'b001011;
	parameter BGTZ   = 6'b000111;
	parameter BLTZ   = 6'b000001;
	parameter BEQ    = 6'b000100;
	parameter BNE    = 6'b000101;
	parameter J      = 6'b000010;
	parameter JAL    = 6'b000011;
	parameter LB     = 6'b100100;
	parameter LW     = 6'b100011;
	parameter SB     = 6'b101000;
	parameter SW     = 6'b101011;
	
	//Funct Parameters
	parameter ADD    = 6'b100000;
	parameter SUB    = 6'b100010;
	parameter AND    = 6'b100100;
	parameter OR     = 6'b100101;
	parameter NOR    = 6'b100111;
	parameter XOR    = 6'b100110;
	parameter SLL    = 6'b000000;
	parameter SLLV   = 6'b000100;
	parameter SRA    = 6'b000011;
	parameter SRAV   = 6'b000111;
	parameter SRL    = 6'b000010;
	parameter SLT    = 6'b101010;
	parameter SLTU   = 6'b101011;
	parameter JR     = 6'b001000;
	
	//Controller
	always @(*) begin
		regdst   <= 0;
		regwr    <= 0;
		memwrite <= 0;
		memtoreg <= 0;
		spen     <= 0;
		worb     <= 0;
		alusrc   <= 2'b0;
		pcsrc    <= 2'b0;
		case (op)
			RTYPE: 
				begin
					if(funct == JR) begin
						pcsrc <= 2'b11;
					end
					else begin
						regdst <= 1;
						alusrc <= 2'b00;
						regwr <= 1;
					end
				end
			ADDI: 
				begin
					regdst <= 0;
					alusrc <= 2'b01;
					regwr <= 1;
				end
			ANDI:
				begin
					regdst <= 0;
					alusrc <= 2'b10;
					regwr <= 1;
				end
			ORI:
				begin
					regdst <= 0;
					alusrc <= 2'b10;
					regwr <= 1;
				end
			XORI:
				begin
					regdst <= 0;
					alusrc <= 2'b10;
					regwr <= 1;
				end
			SLTI:
				begin
					regdst <= 0;
					alusrc <= 2'b01;
					regwr <= 1;
				end
			SLTIU:
				begin
					regdst <= 0;
					alusrc <= 2'b10;
					regwr <= 1;
				end
			BGTZ:
				begin
					alusrc <= 2'b00;
					pcsrc <= trans? 2'b10: 2'b00;
				end
			BLTZ:
				begin
					alusrc <= 2'b00;
					pcsrc <= trans? 2'b10: 2'b00;
				end
			BEQ:
				begin
					alusrc <= 2'b00;
					pcsrc <= trans? 2'b10: 2'b00;
				end
			BNE: 
				begin
					alusrc <= 2'b00;
					pcsrc <= trans? 2'b10: 2'b00;
				end
			J:		pcsrc <= 2'b01;
			JAL:
				begin
					spen <= 1;
					pcsrc <= 2'b01;
				end
			LB: 
				begin
					regdst <= 0;
					alusrc <= 1;
					regwr  <= 1;
					memtoreg <= 1;
					worb <= 0;
				end
			LW:
				begin
					regdst <= 0;
					alusrc <= 1;
					regwr  <= 1;
					memtoreg <= 1;
					worb <= 1;
				end
			SB:
				begin
					regdst <= 0;
					alusrc <= 1;
					memwrite <= 1;
					worb <= 0;
				end	
			SW:
				begin
					regdst <= 0;
					alusrc <= 1;
					memwrite <= 1;
					worb <= 1;
				end	
		endcase
	end
	
	//AluControl
	always @(*) begin
		case (op)
			RTYPE: 
				case (funct)
					ADD:   aluctrl <= 5'b00001;
					SUB:   aluctrl <= 5'b00010;
					AND:   aluctrl <= 5'b00011;
					OR:    aluctrl <= 5'b00100;
					NOR:   aluctrl <= 5'b00101;
					XOR:   aluctrl <= 5'b00110;
					SLL:   aluctrl <= 5'b00111;
					SLLV:  aluctrl <= 5'b01000;
					SRA:   aluctrl <= 5'b01001;
					SRAV:  aluctrl <= 5'b01010;
					SRL:   aluctrl <= 5'b01011;
					SLT:   aluctrl <= 5'b01100;
					SLTU:  aluctrl <= 5'b01101;
					JR:    aluctrl <= 5'b01110;
					default: aluctrl <= 5'b00000;
				endcase
			ADDI:  aluctrl <= 5'b10000;
			ANDI:  aluctrl <= 5'b10001;
			ORI:   aluctrl <= 5'b10010;
			XORI:  aluctrl <= 5'b10011;
			SLTI:  aluctrl <= 5'b10100;                 
			SLTIU: aluctrl <= 5'b10101;
			BGTZ:   aluctrl <= 5'b10110;
			BLTZ:   aluctrl <= 5'b10111;
			BEQ:   aluctrl <= 5'b11000;
			BNE:   aluctrl <= 5'b11001;
			LB:    aluctrl <= 5'b11010;
			LW:    aluctrl <= 5'b11011;
			SB:    aluctrl <= 5'b11100;
			SW:    aluctrl <= 5'b11101;
			default: aluctrl <= 5'b00000;
		endcase
	end
endmodule