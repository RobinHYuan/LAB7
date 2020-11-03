module memorryIO (clk,mem_addr,mem_cmd,read_data,write_data,SW,LEDR);

`define MREAD 2'b10
`define MWRITE 2'b01
`define Mdefault 2'b00

input clk;
input [7:0]  SW;
input [8:0]  mem_addr;
input [1:0]  mem_cmd;
input [15:0] read_data;

output [15:0] write_data;
output [7:0]  LEDR;

wire [7:0] LEDR_in;

assign read_data[15:8] = ((mem_addr==9'h140)&(mem_cmd==`MREAD)) ? 8'h00: {8{1'bz}};
assign read_data[7:0]  = ((mem_addr==9'h140)&(mem_cmd==`MREAD)) ? SW : {8{1'bz}};

assign LEDR_in=((mem_addr==9'h100)&(mem_cmd==`MWRITE)) ? write_data:{8{1'b0}};
RegWithLoad #(8) LED(LEDR_in, clk, ((mem_addr==9'h100)&(mem_cmd==`MWRITE)),LEDR );
endmodule
