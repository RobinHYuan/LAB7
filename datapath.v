module datapath (clk       , 
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
		
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		mdata       ,
		sximm8      ,
		PC          ,
		sximm5      
                );
//>>>>>>>>>>>>>Modified Inputs for LAB6
input [1:0]vsel;
input [15:0] mdata, sximm8, sximm5;
input [7:0] PC;
//>>>>>>>>>>>>>
input clk, write, loada, loadb, loadc, loads, asel, bsel; //signal instantiations
input  [2:0] writenum,readnum;
input  [1:0] ALUop, shift;
output [2:0]Z_out;
output [15:0] datapath_out;
wire [2:0]Z;
wire[15:0] data_in, RegAout, RegBout, sout, B_mux_input, Ain, Bin, out,data_out;

assign B_mux_input =sximm5;//changed for lab6

//mux  #(16) writeback(datapath_out, datapath_in, vsel, data_in); //first multiplexer
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
InputMux Input(mdata,sximm8,PC,datapath_out,vsel,data_in);

regfile REGFILE(data_in,writenum,write,readnum,clk,data_out);//regfile (note that data_in is passed from writeback to regfile)

//register with load: A&B
RegWithLoad #(16) A(data_out, loada, clk, RegAout);//A
RegWithLoad #(16) B(data_out, loadb, clk, RegBout);//B
//shifter-B
shifter B_shift(RegBout, shift, sout); //shifter unit that operates on Bin
//Multiplexer: A & B;
mux #(16) Asel(RegAout, 16'b0, asel, Ain);//determines Ain which is either RegOut or 0 (depending on asel)
mux #(16) Bsel(sout, B_mux_input, bsel, Bin); //determines Bin which is either 0 or sout (depending on bsel)
//ALU:
ALU compute(Ain, Bin, ALUop, out, Z); //does operation on Ain and Bin, outputs "out"
//reg with load:c &z 
RegWithLoad #(16) C (out, loadc, clk, datapath_out); //displays updated datapath_out
RegWithLoad #(3)  status(Z, loads, clk, Z_out);//status is updated as "Z_out" z[2] indicates if the output is negative; z[1] indicates if an overflow occurs; z[0] indicates if the output is negative 
endmodule
