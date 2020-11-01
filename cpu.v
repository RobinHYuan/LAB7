
module cpu(clk, reset,s, load, in, out, N, V, Z, w);
input clk, reset, s, load;
input [15:0] in;
output [15:0] out;
output N, V, Z, w;
wire [15:0] instruction_out;
RegWithLoad #(16) instructionReg(in, load, clk, instruction_out);//REg with load enabled for instruction decoder

wire [15:0]sximm8, mdata, datapath_out, sximm5;
wire [7:0] PC;
wire [2:0] writenum, readnum, opcode,nsel,Z_out;
wire [1:0] ALUop,op,shift,vsel;
wire loada,loadb, asel, loadc, loads, write, bsel;
instructionDecoder decode(instruction_out, sximm8,writenum, readnum,opcode, ALUop, op,shift, nsel);
//instatiate Datapath
datapath DP(  clk         , 
                readnum     , 
                vsel        ,
                loada       ,
                loadb       ,

             
                shift       ,
                asel        ,
                bsel        ,
                ALUop       ,
                loadc       ,
                loads       ,

              
                writenum    ,
                write       ,  
               
                Z_out       ,
                datapath_out,
		
		mdata       ,
		sximm8      ,
		PC          ,
		sximm5      
                );
//instantiate FSM
FSM controller 
(
	clk,
	opcode,
	op,
	ALUop,
	s,
	reset,
	loada,
	loadb,
	loadc,
	nsel,
	write,
	vsel,
	w   ,
	asel,
	bsel,
	loads
);
assign out=datapath_out; //out is C out
assign N=Z_out[0];       //negative
assign V=Z_out[1];       //overflow
assign Z=Z_out[2];       //zero
//not used signals
assign sximm5={16{1'b0}};  
assign PC={8{1'b0}};
assign mdata={16{1'b0}};
endmodule



