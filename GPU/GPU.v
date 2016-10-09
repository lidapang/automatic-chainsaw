`include "txt.v"
`include "font_rom.v"
module GPU(
input clk,
input [15:0] cpuline,
input clr
);

TXT d0 (
		.clk (clk),
		.clr (clr),
		.out_vga (out_vga),
		.char_line_dat (dat),
		.asciiadress (asciiadress),
		.font_mem_en (font_mem_en),
		.dis_mem_en (dis_mem_en),
		.pix_x(pix_x),
		.pix_y(pix_y)
		);

font_rom x0 (
		.clk (font_mem_en),
		.adress ({ascii[6:0], pix_y[3:0], !pix_x[3]}),
		.out (out)
		);
		


assign dat = out;

reg [15:0] cmd;
reg [15:0] param;
reg [11:0] ram [7:0];
reg [11:0] pointer;
reg [11:0] tmpx;
reg [11:0] tmpy;
reg nopsate;
reg [15:0] nextcmd;

reg [7:0] ascii;
always @ (posedge clk) begin: clr
	if (clr) disable clr;
	cmd <= 0;
	param <= 0;
	pointer <= 0;
	tmpx <= 0;
	tmpy <=0;
	nopstate <= 0;
	nextcmd <= 0;
	ascii <= 0;
	end

always @ (posedge dis_mem_en) begin : dismem
	if (!clr) disable dismem;
	ascii <= ram[pointer];
end

always @(posedge clk) begin : main
	if (!clr) disable main;
	case (cmd) begin
		16'h0: begin
			if (!nopstate) begin
				nextcmd <= cpuline;
				nopstate <= 1;
			else begin
				cmd <= nextcmd;
				param <= cpuline;
				nopstate <= 0;
			end
		end
		16'hC0: begin
			if (param == 0) begin
				//if SYSTEMVERILOG
				ram <= '{default:2'b00};
				//else
					//for (i=0; i<8; i=i+1) ram[i] <= 2'b00;
				//endif
				pointer <=0;
				tmpy <=0;
				tmpx <=0;
			else begin
				//graphical mode
			end
		end
		16'hC1: begin
			ram[pointer] <= param;
			pointer <= pointer + 1;
			if(tmpx > 12'd38) begin//0..39
				if(tmpy > 12'd23) //0..24
					tmpy <= 0;
				else tmpy <= tmpy + 1;
				tmpx <= 0;
			else tmpx <= tmpx + 1;
			cmd <= 16'h0;
		end
		16'hC2: begin
			ram[pointer - 1] <= 8'h0;
			pointer <= poiner - 1;
			if(tmpx == 12'h0) begin
				tmpx <= 12'd39;
				tmpy <= tmpy - 1;
			else tmpx <= tmpx - 1;
			cmd <= 16'h0;
		end
		16'hC3: begin
			tmpy <= param;
			pointer = (param << 5) + (param << 3) + tmpx;//Y*40 +x
			cmd <= 16'h0;
		end
		16'hC4 begin
			tmpx <= param;
			pointer = (tmpy << 5) + (tmpy << 3) + param;//X*40 +y
			cmd <= 16'h0;
		end
		16'hC5 begin
			//if SYSTEMVERILOG
			ram <= '{default:2'b00};
			//else
				//for (i=0; i<8; i=i+1) ram[i] <= 2'b00;
			//endif
			pointer <= 0;
			tmpx <= 0;
			tmpy <= 0;
			cmd <= 16'h0;
		end
		16'hC6: begin
			if(tmpy > 12'd23) begin//0..24
				pointer <= 0;//not the best solution
				tmpx <= 0;
				tmpy <= 0;
			else begin
				tmpx <= 0;
				tmpy = tmpy + 1;
				pointer = (tmpy << 5) + (tmpy << 3);//*40
				end
			cmd <= 16'h0;
		end
	
	end
	
endmodule