`timescale 1ns / 1ps

module test2;

	// Inputs
	reg clk;
	reg rst;
	reg send;
	reg [7:0] data;

	// Outputs
	wire txd;
	wire ready;

	// Instantiate the Unit Under Test (UUT)
	s_UART uut (
		.clk(clk), 
		.rst(rst), 
		.send(send), 
		.data(data), 
		.txd(txd), 
		.ready(ready)
	);

	// Odbiornik definicja na dole
	wire recieved;
	wire [7:0]data_odb;
	odbiornik odb(
	 .clk(clk),
    .rst(rst),
	 .recieved(recieved),
    .data(data_odb),
    .rxd(txd)
	 );

	// połączenie odbiornika i nadajnika
	// reg <- wire
	always @(recieved)
		send = recieved;
	 
	 // Odczyt nowych danych
	 // zapis kopii
	 // spacja dla czytelności
	 always @(posedge send)
		begin
			data = $fgetc(file);
			if (stan_zapisu==1)//żeby w pliku porównawczym do matlaba nie było spacji na początku
			$fwrite(fileo," ");
			if (data == 8'hff)
				begin
					$fclose(file);
					$fclose(fileo);
					$fclose(fileo_kopia);
				end
			$fwrite(fileo_kopia,"%c",data);
		end
	// Pliki
	integer file;
	integer fileo;
	integer fileo_kopia;
	
	// zapis - porównanie z matlabem
	reg stan_zapisu;
	always @(posedge clk)
	begin
		if (stan_zapisu==1)
			$fwrite(fileo,txd);
		else if(data_odb==8'hff) begin
			stan_zapisu = 1; $fwrite(fileo,txd); end
		
	end
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		send = 0;
		data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

		rst = 0;
		#3 rst =1;
		file = $fopen("data.txt","r");
		fileo = $fopen("data_oise.txt","w+");
		fileo_kopia = $fopen("data_kopia.txt");
		
	end
	
	
// Zegar      
	parameter PERIOD = 2;
   always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end  
	
// Maszyna Odbierająca dane

endmodule

module odbiornik(
	 input clk,
    input rst,
	 output reg recieved,
    output reg [7:0] data,
    input rxd
	 );

localparam czekaj = 2'b0, pobieraj = 2'b01, zero = 2'b10;

		reg [7:0]data_tmp;
		reg [1:0] stan;
		always @(posedge clk, negedge rst)
		if(!rst) 
			begin 
				ce8 = 0; 
				stan = czekaj;
				recieved = 1;
			end
		else 
		case(stan)
			czekaj: 
				begin
					recieved=0;
					if(rxd == 1)
						begin 
							stan=pobieraj;  
						end
				end
			pobieraj:
				begin
					ce8=1;
					data_tmp[cnt8] = rxd;
					$display("P: %d",cnt8);
					if(cnt8 == 4'd7)
						begin
							stan = zero;
		
						end
				end
			zero:
				begin
					ce8 = 0;
					data = data_tmp;
					if(rxd == 0) begin
						recieved = 1;
						stan = czekaj; end
				end
		endcase



	
	//licznik mod 8
	reg [3:0]cnt8;
	reg ce8;
	always @(posedge clk, negedge rst)
	begin
		if(!rst)
			cnt8 <= 0;
		else
		if(ce8)
		begin
			if(cnt8 != 4'd7)
				cnt8<=cnt8+1;
			else
				cnt8<=0;		
		end
	end
endmodule
