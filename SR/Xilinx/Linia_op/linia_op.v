`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:20:50 03/03/2016 
// Design Name: 
// Module Name:    linia_op 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module linia_op #(parameter N=2, parameter DELAY=0)(
    input [N-1:0]idata,
    output [N-1:0]odata,
    input clk
    );

generate 
genvar i;

if(DELAY>0)
begin
	reg [N-1:0] chain[DELAY-1:0];
	always @(posedge clk)
		chain[0]<=idata;
	for(i=1; i<DELAY; i=i+1)
	begin
	always @(posedge clk)
		chain[i] <= chain[i-1];
	end
	assign odata = chain[DELAY-1];
end
else
	assign odata = idata;

endgenerate

endmodule
