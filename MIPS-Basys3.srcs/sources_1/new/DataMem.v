module DataMem (
	input  wire clk, we, worb,
	input  wire [15:0] addr,
	input  wire [31:0] indata,
	output reg  [31:0] outdata
);
	wire en;
	wire [9:0] taddr;
	reg  [31:0] rdata;
	reg  [31:0] wdata; 
	reg  [31:0] RAM [1024:0];
	
	assign en = (addr[15:12] == 4'h1) ? 1'b1: 1'b0;
	assign taddr = addr[11:2];
	
	always @(posedge clk) begin
		if(en && we) begin
			if(worb == 1'b0) begin
				case (addr[1:0])
					2'b00: RAM[taddr][7:0]   <= indata[7:0];
					2'b01: RAM[taddr][15:8]  <= indata[7:0];
					2'b10: RAM[taddr][23:16] <= indata[7:0];
					2'b11: RAM[taddr][31:24] <= indata[7:0];
				endcase
			end
			else RAM[taddr] <= indata;
		end
	end
	
	always @(*) begin
		if(en) begin
			if(worb == 1'b0) begin
				case (addr[1:0])
					2'b00: outdata <= {24'b0, RAM[taddr][7:0]};
					2'b01: outdata <= {24'b0, RAM[taddr][15:8]};
					2'b10: outdata <= {24'b0, RAM[taddr][23:16]};
					2'b11: outdata <= {24'b0, RAM[taddr][31:24]};
				endcase
			end
			else outdata <= RAM[taddr];
		end
		else outdata <= 32'b0;
	end
endmodule
	