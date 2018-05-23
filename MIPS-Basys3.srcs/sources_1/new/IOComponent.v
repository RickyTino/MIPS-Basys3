module IOComponent (
	input wire         clk, reset, iowr,
	input wire  [15:0] switch,      
	input wire  [3 :0] keys,        
	input wire  [15:0] addr,        
	input wire  [31:0] writedata,   
	output reg  [31:0] readdata,    
	output reg  [3 :0] an,       
	output reg  [7 :0] ca,
	output reg  [15:0] led
);

	//FF00 - FF01 16bit switch  [ReadOnly]
	//FF02 8bit 3:0 keys [0:up, 1:down, 2:left, 3:right]; [ReadOnly]
	//FF03 - FF06 digit
	//FF07 - FF08 16bit LED
	
	//Data Exchanging
	
	reg [7:0] digit [0:3];
	
	initial begin
		digit[0] = 8'b0;
		digit[1] = 8'b0;
		digit[2] = 8'b0;
		digit[3] = 8'b0;
		led      = 16'b0;
	end
	
	always @(*) begin
		case(addr)
			16'hFF00: readdata <= {24'b0, switch[7:0]};
			16'hFF01: readdata <= {24'b0, switch[15:8]};
			16'hFF02: readdata <= {28'b0, keys};
			16'hFF03: readdata <= {24'b0, digit[0]};
			16'hFF04: readdata <= {24'b0, digit[1]};
			16'hFF05: readdata <= {24'b0, digit[2]};
			16'hFF06: readdata <= {24'b0, digit[3]};
			16'hFF07: readdata <= {24'b0, led[7:0]};
			16'hFF08: readdata <= {24'b0, led[15:8]};
			default: readdata <= 32'b0;
		endcase
	end
	
	always @(posedge clk, posedge reset) begin
		if(reset) begin
			digit[0] <= 8'b0;
			digit[1] <= 8'b0;
			digit[2] <= 8'b0;
			digit[3] <= 8'b0;
			led      <= 16'b0;
		end
		else if(iowr) begin
			case(addr)
				16'hFF03: digit[0]  <= writedata[7:0];
				16'hFF04: digit[1]  <= writedata[7:0];
				16'hFF05: digit[2]  <= writedata[7:0];
				16'hFF06: digit[3]  <= writedata[7:0];
				16'hFF07: led[7:0]  <= writedata[7:0];
				16'hFF08: led[15:8] <= writedata[7:0];
			endcase
		end
	end	
/*
	reg [7:0] digit0, digit1, digit2, digit3;
	
	always @(*) case(addr)
		16'hFF00: readdata <= {24'b0, switch[7:0]};
		16'hFF01: readdata <= {24'b0, switch[15:8]};
		default:  readdata <= 32'b0;
	endcase
	
	always @(posedge clk) if(iowr) case(addr)
		16'hFF03: digit0  <= writedata[7:0];
		16'hFF04: digit1  <= writedata[7:0];
		16'hFF05: digit2  <= writedata[7:0];
		16'hFF06: digit3  <= writedata[7:0];
		16'hFF07: led[ 7:0] <= writedata[7:0];
		16'hFF08: led[15:8] <= writedata[7:0];
	endcase
*/
	wire dspclk;	
	
	ClockDivision cd (
		.iclk (clk),
		.oclk (dspclk)
	);
	
	//Digit Show
	reg [1:0] cnt;
	
	initial begin
		an = 4'b1110;
		cnt = 2'b1;
	end
		
	always @(posedge dspclk) begin
		an  <= {an[2:0], an[3]};
		ca  <= ~digit[cnt];
		cnt <= cnt + 1;
	end
	/*
	always @(*) case(cnt)
		2'd0: ca = ~digit0;
		2'd1: ca = ~digit1;
		2'd2: ca = ~digit2;
		2'd3: ca = ~digit3;
	endcase
	
	always @(*) begin
		an[0] = (cnt == 0) ? 0 : 1;
		an[1] = (cnt == 1) ? 0 : 1;
		an[2] = (cnt == 2) ? 0 : 1;
		an[3] = (cnt == 3) ? 0 : 1;
	end
	*/
endmodule

