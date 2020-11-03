`define MREAD 2'b10
`define MWRITE 2'b01
`define Mdefault 2'b00

module InputMux(Mdata,Sximm8,pc,Datapath_out,Vsel,Datapath_in); 
// This is a dedicated mux module to feed input into the Regfile inside datapath; select signal is in binary

input [15:0] Mdata, Sximm8, Datapath_out;
input [7:0] pc;
input [1:0] Vsel; // This binary mutiplexer takes a binary slect signal from 2'b00 to 2'b11;
output [15:0] Datapath_in;
reg [15:0] Datapath_in;

always @(*)
case (Vsel)
2'b00: Datapath_in = Datapath_out; //vsel=0, we have a write back function
2'b01: Datapath_in = {8'b0, pc};   //vsel=1, we have Datapath_in = {8'b0, pc} 
2'b10: Datapath_in = Sximm8;       //vsel=2, we ouput the sign extended immediate operand
2'b11: Datapath_in = Mdata;        //vsel=3, we have the Mdata as an output
default: Datapath_in = {16{1'bx}}; //default, it should never appears as a valid output
endcase

endmodule




//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
module instructionDecoder(instruction, immediate,writenum, readnum,opcode, ALUop, op,shift, nsel);
input [15:0] instruction; 		//from instruction register
input  [2:0] nsel;        		//nsel from FSM to control
output [2:0] writenum, readnum, opcode; 
output [15:0] immediate;                //imm8
output [1:0] ALUop, shift,op;              
wire [2:0] Rn, Rd, Rm;
reg [2:0] writenum, readnum;
/*always@(*)
case(instruction[15:13])
101: ALUop = instruction [12:11]; 
     shift = instruction [4:3];
     if(instruction[12:11]==2'b00)
	if(nsel=2'b00) readnum=instruction[10:8];
	else if(nsel=2'b01) readnum=instruction[2:0];
	     else if(nsel=2'b11) writenum=instruction[7:5];
	          else begin writenum=2'bzz; readnum=2'bzz; end 
	else if(instruction[12:11]==2'b00)
		if(nsel=2'b00) readnum=instruction[10:8];[
		else if(nsel=2'b01) readnum=instruction[2:0];
		     else begin writenum=2'bzz; readnum=2'bzz; end */

assign opcode = instruction[15:13]; //opcode for FSM
assign op = instruction [12:11];    //op fpr fsm
assign ALUop= instruction [12:11];  //ALUop fpr datapath

assign immediate = (instruction[7]==1) ? ({8'sb1111_1111,instruction [7:0]}): ({8'sb0000_0000,instruction [7:0]}); //sign extend the immediate oeprand
assign shift = instruction[4:3];  //shift for datapath
assign Rn = instruction [10:8];    //register Rn
assign Rd = instruction [7:5];     //Register Rd
assign Rm = instruction [2:0];     //Register Rm

always @(*)                //output the correct readnum/writenum depending on the nsel signal
case (nsel)
3'b001: if(op==2'b10) 
	{writenum,readnum}={Rn,3'bxxx};
	else 
	{readnum,writenum}={Rm,3'bxxx};
3'b010: {readnum,writenum}={Rm,3'bxxx};
3'b100: {writenum,readnum}={Rd,3'bxxx};
3'b101: {readnum,writenum}={Rn,3'bxxx};
3'b110: {readnum,writenum}={Rd,3'bxxx};
default:{readnum,writenum}=6'bxxx_xxx;
endcase
endmodule

module Program_Counter(reset_pc, load_pc ,PC, clk); //This module also contains the PC multiplexer 
input  reset_pc, load_pc, clk;
output [8:0] PC;
wire   [8:0] next_pc;
assign next_pc=(reset_pc)? 0: (PC+9'b0000_0000_1);
RegWithLoad #(9) pc_reg(next_pc, load_pc, clk, PC);
endmodule

module instruct_address(PC,datapath_out,load_addr,addr_sel, mem_addr, clk);
input [8:0] datapath_out, PC;
input load_addr, addr_sel, clk;
output [8:0] mem_addr;
wire [8:0] Data_out;
assign mem_addr=(addr_sel) ? PC:Data_out;
RegWithLoad #(9) data_addr(datapath_out, load_addr, clk, Data_out);
endmodule


module read_writeRAM(mem_addr,mem_cmd,read_data,datapath_out,write_data,dout,clk,read_address,write_address,write);
input [8:0] mem_addr;
input [15:0] dout, datapath_out;
input clk;
input [1:0]mem_cmd;
output [15:0] read_data, write_data;
output [7:0] read_address,write_address;
output write;

wire read_condition1= (mem_cmd==`MREAD) ? 1:0;
wire read_condition2=  (mem_addr[8]==0) ? 1:0;

wire write_condition1= (mem_cmd==`MWRITE) ? 1:0;
wire write_condition2=  (mem_addr[8]==0) ? 1:0;

assign write_address=mem_addr[7:0];
assign read_address=mem_addr[7:0];

assign write=write_condition1&write_condition2;

assign write_data=datapath_out;
assign read_data=((read_condition1&read_condition2)==1) ? dout: {16{1'bz}};
endmodule
