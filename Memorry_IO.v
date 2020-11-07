module memorryIO (clk,mem_addr,mem_cmd,read_data,write_data,SW,LEDR);

`define MREAD 2'b10
`define MWRITE 2'b01
`define Mdefault 2'b00

input clk;
input [7:0]  SW;
input [8:0]  mem_addr;
input [1:0]  mem_cmd;
output [15:0] read_data;

input [15:0] write_data;
output [9:0]  LEDR;

wire [9:0] LEDR_in;
reg [15:0] read_data;

//assign read_data[15:8] = ((mem_addr==9'h140)&(mem_cmd==`MREAD)) ? 16'b0: {8{1'bz}};
//
always @(*)
case({mem_addr,mem_cmd})
{9'h140,`MREAD}: read_data={{8{1'b0}},SW};
default: read_data={16{1'bz}};
endcase  

assign LEDR_in=((mem_addr==9'h100)&(mem_cmd==`MWRITE)) ? {2'b0,{write_data[7:0]}}:{10{1'b0}};
RegWithLoad #(10) LED(LEDR_in, ((mem_addr==9'h100)&(mem_cmd==`MWRITE)),clk,LEDR );
endmodule
