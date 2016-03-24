`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:30:22 03/03/2016
// Design Name:   linia_op
// Module Name:   /home/lsriw/sr/Radzio_Lukasz/Linia_op/tb_linia_op.v
// Project Name:  Linia_op
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: linia_op
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_linia_op;

	// Inputs
	reg [4:0] idata;
	reg clk;

	// Outputs
	wire [4:0] odata;

	// Instantiate the Unit Under Test (UUT)
	linia_op #(5,4)uut (
		.idata(idata), 
		.odata(odata), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		idata = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		while(1)
		begin
			#10; clk =1'b0;
			#10; clk = 1'b1;
		end
		
	end
   always @(posedge clk)
	begin
		#5; idata = 5'b11111;
		#50; idata = 5'b00000;
	end
endmodule

