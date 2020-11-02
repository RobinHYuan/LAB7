
module lab7_top(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, reset,clk);
input [3:0] KEY;
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;

input reset,clk;
wire clk, reset,N, V, Z, w, write;
wire [1:0]  mem_cmd;
wire [7:0]  read_address, write_address;
wire [8:0]  mem_addr;
wire [15:0] read_data, write_data, datapath_out, dout;


RAM #(16,8, "data.txt")MEM     (clk,read_address,write_address,write,write_data,dout);
cpu                    CPU     (clk, reset, read_data, datapath_out, N, V, Z, w, mem_cmd, mem_addr);
read_writeRAM          RW      (mem_addr,mem_cmd,read_data,datapath_out,write_data,dout,clk,read_address,write_address,write);
endmodule




module tb();

reg reset, clk;
wire [3:0] KEY;
wire [9:0] SW;
wire [9:0] LEDR;
wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
lab7_top DUT(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, reset,clk);

initial begin
forever begin
clk=0;#5;
clk=1;#5;
end
end

initial begin
reset=1;#10;
reset=0;
#2500;
$stop;
end


endmodule