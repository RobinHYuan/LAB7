
module cpu(clk, reset, in, out, N, V, Z, w, mem_cmd,mem_addr,PC);
input clk, reset; //s,load
input [15:0] in; //read_data that goes into instruction reg
output [15:0] out;
output N, V, Z, w;
output [1:0] mem_cmd;
wire [15:0] instruction_out;
wire  reset_pc, load_pc, load_addr, addr_sel,  load_ir;
wire   [1:0] mem_cmd;
output [8:0] mem_addr;
RegWithLoad #(16) instructionReg(in, load_ir, clk, instruction_out);//REg with load enabled for instruction decoder
output [8:0] PC;
wire [15:0]sximm8, mdata, datapath_out, sximm5;
wire [8:0] PC;
wire [7:0] PC_DP=PC[7:0];
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
		PC_DP          ,
		sximm5      
                );
//instantiate FSM
FSM controller 
(
	clk,
	opcode,
	op,
	ALUop,
	//s,
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
	loads, 
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	reset_pc,  //for PC
	load_pc,   //for PC
	load_addr,
	addr_sel,
	mem_cmd,
	load_ir
);
wire [8:0] data_addressIN = datapath_out[8:0];
Program_Counter pc(reset_pc, load_pc ,PC, clk);
instruct_address adressREG(PC,data_addressIN,load_addr,addr_sel, mem_addr, clk); //output mem_addr
assign out=datapath_out; //out is C out
assign N=Z_out[0];       //negative
assign V=Z_out[1];       //overflow
assign Z=Z_out[2];       //zero
//not used signals
assign sximm5=(instruction_out[4]==1) ?({11'sb1111_1111_111,instruction_out[4:0]}):({11'sb0000_0000_000,instruction_out[4:0]});
assign mdata=in;
endmodule



