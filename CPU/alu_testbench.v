module testbench();

	reg [15:0] a;
	reg [15:0] b;
	reg [7:0] op;
	reg cf;
	reg clk; 
	wire c_flag;
	wire z_flag;
	wire o_flag;
	wire [15:0] acc;
	wire [15:0] c;
	
	alu d0 (
		.clk (clk),
		.a(a),
		.b(b),
		.op(op),
		.cf(cf),
		.c_flag(c_flag),
		.z_flag(z_flag),
		.o_flag(o_flag),
		.acc(acc),
		.c(c)
	);
	
	
	initial begin
		//$display ("time\t clk a b op cf");
		$monitor ("%g\t %b %b %b %b %b %b %b %b %b %b",
		$time, clk, a, b, op, cf, c_flag, o_flag, z_flag, acc, c);
		clk = 1;
		a = 16'd10;
		b = 16'd11;
		op = 8'd2;
		cf = 1;
		#15 $finish;
	end
	  
	always begin
		#5 clk =~clk;
	end
	
endmodule