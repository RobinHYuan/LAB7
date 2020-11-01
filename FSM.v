module FSM 
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

input clk, s, reset;
input [2:0] opcode;
input [1:0] op, ALUop;
output loada, loadb, loadc, write, w,asel,bsel,loads;
output [1:0] vsel;
output [2:0] nsel;


reg[4:0] current_state;
reg loada, loadb, loadc, write, w,asel,bsel,loads;
reg [1:0] vsel;
reg [2:0] nsel;



`define Wait        5'b0_0000
`define decode      5'b0_0001
`define decode_move 5'b0_0010
`define decode_ALU  5'b0_0011
`define moveA1      5'b0_0100
`define moveB1      5'b0_0101
`define moveB2      5'b0_0110
`define moveB3      5'b0_0111
`define ADD_1       5'b0_1000
`define CMP_1	    5'b0_1001
`define AND_1       5'b0_1010
`define MVN_1       5'b0_1011
`define ADD_2       5'b0_1100
`define ADD_3       5'b0_1101
`define ADD_4       5'b0_1110

`define AND_2       5'b1_0000
`define AND_3       5'b1_0001
`define AND_4       5'b1_0010
`define MVN_2       5'b1_0011
`define MVN_3       5'b1_0100
`define CMP_2	    5'b1_0101
`define CMP_3	    5'b1_0110
always@(posedge clk)begin// state machine 
//macros are used to better illustrate the traisitions between states

if(reset) 
   current_state=`Wait;

	else begin 
		case(current_state)

		`Wait: if(s) current_state = `decode;
		       else current_state = `Wait;

		`decode:if(opcode==3'b110)      current_state=`decode_move;
			else if(opcode==3'b101) current_state=`decode_ALU ;
			     else current_state={5{1'bx}};

		`decode_move: if(op==2'b10)     current_state=`moveA1;
			      else if(op==2'b00) current_state=`moveB1;
				   else current_state={5{1'bx}};

		`decode_ALU: if(ALUop==2'b00)  current_state=`ADD_1; //copy Rn into Register A
				else if(ALUop==2'b01) current_state=`CMP_1;
					else if(ALUop==2'b10) current_state=`AND_1;
						else if (ALUop==2'b11) current_state=`MVN_1;
							else current_state={5{1'bx}};				
		`moveA1: current_state=`Wait;
		`moveB1: current_state=`moveB2;
		`moveB2: current_state=`moveB3;
		`moveB3: current_state=`Wait;

	        `ADD_1:  current_state=`ADD_2;
		`ADD_2:  current_state=`ADD_3;		 //At ADD_2, we want to copy Rm in
		`ADD_3:  current_state=`ADD_4; //At ADD_3, we want to compute and save the result at Register C  
		`ADD_4:  current_state=`Wait; //At ADD_4, we want to wtite the result into Rd and then go back to wait state
		
		`AND_1:  current_state=`AND_2;
		`AND_2:  current_state=`AND_3;
		`AND_3:  current_state=`AND_4;
		`AND_4:  current_state=`Wait;

		`MVN_1:  current_state=`MVN_2;
		`MVN_2:  current_state=`MVN_3;
		`MVN_3:  current_state=`Wait;

		`CMP_1:  current_state=`CMP_2; //load Rn to a at cmp_1
		`CMP_2:  current_state=`CMP_3;//load rm tob at cmp_2
		`CMP_3:  current_state=`Wait;

		default: current_state={5{1'bx}};
			
		endcase
	end
case(current_state)       // output the correct signals depending on the state we are at
`Wait:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}  = 13'b000_0_00_000_1_00_0;//in this section, we pretty much dont do anything
`decode:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b000_0_00_000_0_00_0;
`decode_move:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}=13'b000_0_00_000_0_00_0;
`decode_ALU:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}=13'b000_0_00_000_0_00_0;
`moveA1:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}=13'b000_1_10_001_0_00_0;

`moveB1:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}=13'b010_0_00_001_0_10_0;//load Rd to register B
`moveB2:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b001_0_00_001_0_10_0;//Asel=1; ADD
`moveB3:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b001_1_00_100_0_10_0;

`ADD_1:	{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b100_0_00_101_0_00_0; //read Rn write nothing
`ADD_2: {loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b010_0_00_010_0_00_0;//read Rm write nothing
`ADD_3: {loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b001_0_00_000_0_00_0; //compute and store the result at Reg C
`ADD_4: {loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b000_1_00_100_0_00_0;//write the rsult into Rd

`AND_1:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b100_0_00_101_0_00_0;//read Rn write nothing
`AND_2:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b010_0_00_010_0_00_0;//read Rm write nothing
`AND_3:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b001_0_00_000_0_00_0;//compute (& it) and store the result into Reg
`AND_4:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b000_1_00_100_0_00_0;//write the result into Rd

`MVN_1:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b010_0_00_010_0_00_0;//read Rm write nothing
`MVN_2:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b001_0_00_000_0_00_0;//compute (~) and store the result into Reg
`MVN_3:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b000_1_00_100_0_00_0;//write the result into Rd

`CMP_1:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b100_0_00_101_0_00_0;//read Rm write nothing
`CMP_2:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b010_0_00_010_0_00_0;//read Rm write nothing
`CMP_3:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}= 13'b001_0_00_000_0_00_1;

default:{loada,loadb,loadc,write,vsel,nsel,w,asel,bsel,loads}={13{1'bx}};
endcase
end



endmodule
