//something wrong with sra and srav
module ALUShift(
	input wire [31:0] a, b,
	input wire [4:0] shamt,
	output reg [31:0] sll, sllv, sra, srav, srl
);
	
	wire [31:0] sign = b[31] ? ~(32'b0) : 32'b0;
	
	always @(*) begin
		case (shamt)
			5'd0:  sll <= b;
			5'd1:  sll <= b << 1;
			5'd2:  sll <= b << 2;
			5'd3:  sll <= b << 3;
			5'd4:  sll <= b << 4;
			5'd5:  sll <= b << 5;
			5'd6:  sll <= b << 6;
			5'd7:  sll <= b << 7;
			5'd8:  sll <= b << 8;
			5'd9:  sll <= b << 9;
			5'd10: sll <= b << 10;
			5'd11: sll <= b << 11;
			5'd12: sll <= b << 12;
			5'd13: sll <= b << 13;
			5'd14: sll <= b << 14;
			5'd15: sll <= b << 15;
			5'd16: sll <= b << 16;
			5'd17: sll <= b << 17;
			5'd18: sll <= b << 18;
			5'd19: sll <= b << 19;
			5'd20: sll <= b << 20;
			5'd21: sll <= b << 21;
			5'd22: sll <= b << 22;
			5'd23: sll <= b << 23;
			5'd24: sll <= b << 24;
			5'd25: sll <= b << 25;
			5'd26: sll <= b << 26;
			5'd27: sll <= b << 27;
			5'd28: sll <= b << 28;
			5'd29: sll <= b << 29;
			5'd30: sll <= b << 30;
			5'd31: sll <= b << 31;
		endcase
		
		case (a[4:0])
			5'd0:  sllv <= b;
			5'd1:  sllv <= b << 1;
			5'd2:  sllv <= b << 2;
			5'd3:  sllv <= b << 3;
			5'd4:  sllv <= b << 4;
			5'd5:  sllv <= b << 5;
			5'd6:  sllv <= b << 6;
			5'd7:  sllv <= b << 7;
			5'd8:  sllv <= b << 8;
			5'd9:  sllv <= b << 9;
			5'd10: sllv <= b << 10;
			5'd11: sllv <= b << 11;
			5'd12: sllv <= b << 12;
			5'd13: sllv <= b << 13;
			5'd14: sllv <= b << 14;
			5'd15: sllv <= b << 15;
			5'd16: sllv <= b << 16;
			5'd17: sllv <= b << 17;
			5'd18: sllv <= b << 18;
			5'd19: sllv <= b << 19;
			5'd20: sllv <= b << 20;
			5'd21: sllv <= b << 21;
			5'd22: sllv <= b << 22;
			5'd23: sllv <= b << 23;
			5'd24: sllv <= b << 24;
			5'd25: sllv <= b << 25;
			5'd26: sllv <= b << 26;
			5'd27: sllv <= b << 27;
			5'd28: sllv <= b << 28;
			5'd29: sllv <= b << 29;
			5'd30: sllv <= b << 30;
			5'd31: sllv <= b << 31;
		endcase
		
		case (shamt)
			5'd0:  sra <= b;
			5'd1:  sra <= {sign[0], b[31:1]};
			5'd2:  sra <= {sign[1:0], b[31:2]};
			5'd3:  sra <= {sign[2:0], b[31:3]};
			5'd4:  sra <= {sign[3:0], b[31:4]};
			5'd5:  sra <= {sign[4:0], b[31:5]};
			5'd6:  sra <= {sign[5:0], b[31:6]};
			5'd7:  sra <= {sign[6:0], b[31:7]};
			5'd8:  sra <= {sign[7:0], b[31:8]};
			5'd9:  sra <= {sign[8:0], b[31:9]};
			5'd10: sra <= {sign[9:0], b[31:10]};
			5'd11: sra <= {sign[10:0], b[31:11]};
			5'd12: sra <= {sign[11:0], b[31:12]};
			5'd13: sra <= {sign[12:0], b[31:13]};
			5'd14: sra <= {sign[13:0], b[31:14]};
			5'd15: sra <= {sign[14:0], b[31:15]};
			5'd16: sra <= {sign[15:0], b[31:16]};
			5'd17: sra <= {sign[16:0], b[31:17]};
			5'd18: sra <= {sign[17:0], b[31:18]};
			5'd19: sra <= {sign[18:0], b[31:19]};
			5'd20: sra <= {sign[19:0], b[31:20]};
			5'd21: sra <= {sign[20:0], b[31:21]};
			5'd22: sra <= {sign[21:0], b[31:22]};
			5'd23: sra <= {sign[22:0], b[31:23]};
			5'd24: sra <= {sign[23:0], b[31:24]};
			5'd25: sra <= {sign[24:0], b[31:25]};
			5'd26: sra <= {sign[25:0], b[31:26]};
			5'd27: sra <= {sign[26:0], b[31:27]};
			5'd28: sra <= {sign[27:0], b[31:28]};
			5'd29: sra <= {sign[28:0], b[31:29]};
			5'd30: sra <= {sign[29:0], b[31:30]};
			5'd31: sra <= {sign[30:0], b[31]};
		endcase
		
		
		case (a[4:0])
			5'd0:  srav <= b;
			5'd1:  srav <= {sign[0], b[31:1]};
			5'd2:  srav <= {sign[1:0], b[31:2]};
			5'd3:  srav <= {sign[2:0], b[31:3]};
			5'd4:  srav <= {sign[3:0], b[31:4]};
			5'd5:  srav <= {sign[4:0], b[31:5]};
			5'd6:  srav <= {sign[5:0], b[31:6]};
			5'd7:  srav <= {sign[6:0], b[31:7]};
			5'd8:  srav <= {sign[7:0], b[31:8]};
			5'd9:  srav <= {sign[8:0], b[31:9]};
			5'd10: srav <= {sign[9:0], b[31:10]};
			5'd11: srav <= {sign[10:0], b[31:11]};
			5'd12: srav <= {sign[11:0], b[31:12]};
			5'd13: srav <= {sign[12:0], b[31:13]};
			5'd14: srav <= {sign[13:0], b[31:14]};
			5'd15: srav <= {sign[14:0], b[31:15]};
			5'd16: srav <= {sign[15:0], b[31:16]};
			5'd17: srav <= {sign[16:0], b[31:17]};
			5'd18: srav <= {sign[17:0], b[31:18]};
			5'd19: srav <= {sign[18:0], b[31:19]};
			5'd20: srav <= {sign[19:0], b[31:20]};
			5'd21: srav <= {sign[20:0], b[31:21]};
			5'd22: srav <= {sign[21:0], b[31:22]};
			5'd23: srav <= {sign[22:0], b[31:23]};
			5'd24: srav <= {sign[23:0], b[31:24]};
			5'd25: srav <= {sign[24:0], b[31:25]};
			5'd26: srav <= {sign[25:0], b[31:26]};
			5'd27: srav <= {sign[26:0], b[31:27]};
			5'd28: srav <= {sign[27:0], b[31:28]};
			5'd29: srav <= {sign[28:0], b[31:29]};
			5'd30: srav <= {sign[29:0], b[31:30]};
			5'd31: srav <= {sign[30:0], b[31]};
		endcase
		
		case (shamt)
			5'd0:  srl <= b;
			5'd1:  srl <= b >> 1;
			5'd2:  srl <= b >> 2;
			5'd3:  srl <= b >> 3;
			5'd4:  srl <= b >> 4;
			5'd5:  srl <= b >> 5;
			5'd6:  srl <= b >> 6;
			5'd7:  srl <= b >> 7;
			5'd8:  srl <= b >> 8;
			5'd9:  srl <= b >> 9;
			5'd10: srl <= b >> 10;
			5'd11: srl <= b >> 11;
			5'd12: srl <= b >> 12;
			5'd13: srl <= b >> 13;
			5'd14: srl <= b >> 14;
			5'd15: srl <= b >> 15;
			5'd16: srl <= b >> 16;
			5'd17: srl <= b >> 17;
			5'd18: srl <= b >> 18;
			5'd19: srl <= b >> 19;
			5'd20: srl <= b >> 20;
			5'd21: srl <= b >> 21;
			5'd22: srl <= b >> 22;
			5'd23: srl <= b >> 23;
			5'd24: srl <= b >> 24;
			5'd25: srl <= b >> 25;
			5'd26: srl <= b >> 26;
			5'd27: srl <= b >> 27;
			5'd28: srl <= b >> 28;
			5'd29: srl <= b >> 29;
			5'd30: srl <= b >> 30;
			5'd31: srl <= b >> 31;
		endcase
	end
endmodule 