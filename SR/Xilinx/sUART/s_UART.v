`timescale 1ns / 1ps

// Create Date:    21:12:05 02/28/2016 

module s_UART(
    input clk,
    input rst,
    input send,
    input [7:0] data,
    output reg txd,
	 output reg ready
    );

localparam s1=2'b0, s2=2'b1, s3=2'b10, s4=2'b11;
reg ce;
wire [2:0]cnt;
reg [1:0] state;
reg send_old;
reg send_new;
reg [7:0] data_w;
licznik_mod_8 lm8_1(clk,rst,ce,cnt);

// wykrywanie zbocza send, 1-rst-~rst-1 traktowane jako zbocze up
always @(posedge clk, negedge rst)
	if(!rst) begin
		send_old = 0;
		send_new = 0;
	end else begin
		send_old = send_new;
		send_new = send;
	end

always @(posedge clk, negedge rst)
	if(!rst)
	begin
		txd=0;
		ce=0;
		state = s1;
		ready = 1;
	end else 
			case(state)
			s1:
			begin
				if({send_new,send_old}==2'b10)
				begin
					data_w = data;
					state = s2;
					ready = 0;
				end
				else
				begin
					state = s1;
				end
			end
			s2:
			begin
				txd = 1;
				ce = 1;
				state = s3;
			end
			s3:
			begin
				txd = data_w[cnt];
				if(cnt==3'd7) begin
					state = s4;
					ce = 0; 
				end
			end
			s4:
			begin
				txd = 0;
				state = s1;
				ready = 1;
			end
			endcase
		

endmodule

module licznik_mod_8(input clk, input rst,input ce, output [2:0]cnt);
reg [2:0] cnt_tmp;
always @(posedge clk, negedge rst)
	if (!rst)
		cnt_tmp <= 0;
	else
		if(ce) begin
			cnt_tmp<=cnt_tmp+1; end
		else
			cnt_tmp <= cnt_tmp;
assign cnt = cnt_tmp;

endmodule