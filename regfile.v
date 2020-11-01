module regfile(data_in,writenum,write,readnum,clk,data_out); //should be named REGFILE? (look at lab handout)

input [15:0] data_in;    //signal instantiations
input [2:0] writenum, readnum;
input write, clk;
output [15:0] data_out;
wire p0, p1, p2, p3, p4, p5, p6, p7;
wire[7:0]writeDecoderPosition, readDecoderPosition;
wire[15:0] R0, R1, R2, R3, R4, R5, R6, R7, data_out;
Decoder #(3,8) Write(writenum,writeDecoderPosition);


assign p0=writeDecoderPosition[0]&write ; //chooses which reg to put the 16 bit signal "data_in" into
assign p1=writeDecoderPosition[1]&write ; //only one of these should be 1 during write
assign p2=writeDecoderPosition[2]&write;
assign p3=writeDecoderPosition[3]&write;
assign p4=writeDecoderPosition[4]&write;
assign p5=writeDecoderPosition[5]&write;
assign p6=writeDecoderPosition[6]&write;
assign p7=writeDecoderPosition[7]&write;

RegWithLoad #(16) r0(data_in,p0, clk, R0); //16 bit input goes into RegWithLoad, Rx is the (16-bit) output which leads to mux
RegWithLoad #(16) r1(data_in,p1, clk, R1);
RegWithLoad #(16) r2(data_in,p2, clk, R2);
RegWithLoad #(16) r3(data_in,p3, clk, R3);
RegWithLoad #(16) r4(data_in,p4, clk, R4);
RegWithLoad #(16) r5(data_in,p5, clk, R5);
RegWithLoad #(16) r6(data_in,p6, clk, R6);
RegWithLoad #(16) r7(data_in,p7, clk, R7);

Decoder #(3,8) Read(readnum,readDecoderPosition);
FinalSelectMux OUT(R0, R1, R2, R3, R4, R5, R6, R7,readDecoderPosition,data_out); //chooses signal to output (as 16 bit "data_out")
endmodule 
//SubModules

module mux(signalZero, signalOne, select, signalOut); // a variable input-size mux  	
 parameter n=2;	
 input [n-1:0] signalZero, signalOne;	
 input select;	
 output [n-1:0] signalOut;	

 assign signalOut =(select==1) ? signalOne: signalZero;	
endmodule	


module FinalSelectMux (R0, R1, R2, R3, R4, R5, R6, R7, position, data_out); // a mux that selects the correct output by reading the provided one-hot code
input [15:0] R0, R1, R2, R3, R4, R5, R6, R7; 
input [7:0] position;
output [15:0] data_out;
reg [15:0] data_out;

//macro file for the one-hot code for the postion of each register
`define r0 8'b00_000_001
`define r1 8'b00_000_010
`define r2 8'b00_000_100
`define r3 8'b00_001_000
`define r4 8'b00_010_000
`define r5 8'b00_100_000
`define r6 8'b01_000_000
`define r7 8'b10_000_000
 // an undefined situation which should never appear as a correct output signal

always@(*)begin
case(position)
`r0: data_out=R0;
`r1: data_out=R1;
`r2: data_out=R2;
`r3: data_out=R3;
`r4: data_out=R4;
`r5: data_out=R5;
`r6: data_out=R6;
`r7: data_out=R7;
default data_out={16{1'bx}};
endcase
end

endmodule


module RegWithLoad (in, load, clk, out); //RegWithLoad
parameter n=2;
input [n-1:0] in;
input load, clk;
output [n-1:0] out;
wire [n-1:0] muxOut;
reg [n-1:0] out;

assign muxOut=(load==1'b1)? in:out; //muxOut depends on load signal; if load == 1, muxOut changes to in, if not it shouldn't change

always@(posedge clk) //on the positive edge of clk, out changes to muxOut
begin
out=muxOut;
end
endmodule


module Decoder(BinaryIn, OneHotOut); //simple decoder that converts binary to one-hot
parameter n=3;
parameter m=8;
 input [n-1:0] BinaryIn;
 output[m-1:0] OneHotOut;
 assign OneHotOut=1<<BinaryIn;
 
endmodule

