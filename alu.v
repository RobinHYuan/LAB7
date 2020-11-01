module ALU(Ain, Bin, ALUop, out, Z); //ARITHMETIC LOGIC UNIT
  input [15:0] Ain, Bin; //16 bit bus inputs
  input [1:0] ALUop;  //opertation signal
  output [15:0] out; //output
  output [2:0] Z;//out put to statuts reg with load
  wire [15:0] plus, subtract, And, inverse,Ain, Bin, Carry_in;//intermidiate wires
  wire [1:0]  Carry_out;
  reg [15:0] out;//output
  wire  Z_1, V_1, N_1, sub;
  `define XX 16'bxxxx_xxxx_xxxx_xxxx //An undefined 16-bit signal, which should never appear as an output

  
  assign plus=Ain + Bin; //addition
  assign subtract= Ain - Bin;//subtraction
  assign And=Ain & Bin;//bitwise AND
  assign inverse=~Bin; //INVERSE
  
  always@(*) begin//always block(all inputs are included)
  case(ALUop)//cases are determined by ALUop signla
  2'b00: out=plus;   //add
  2'b01: out=subtract;//minus
  2'b10: out=And;//bitwise and
  2'b11: out=inverse;//inverse
  default out=`XX;//default(shouldnt happen)
  endcase
  end


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Overflow Algorithm begin

  assign sub=(ALUop==2'b01) ? 1:0;   //detect subtraction

  assign Carry_in=(Ain[14:0]+ ((Bin[14:0])^{15{sub}}) )+sub;
  assign Carry_out=(Ain[15]+(Bin[15]^sub))+Carry_in[15];

  assign V_1=(ALUop[1]==0) ? Carry_in[15]^Carry_out[1]: 0 ; //detect overflow; overflow will only happen if we perform addition or subtraction on the operands
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Overflow Algorithm end
  assign N_1=out[15];  //detect whether out is negative
  assign Z_1 = (out == 0) ? 1'b1 : 1'b0;// if out is exactly 0, z will be assigned 1 otherwise 0
  
  assign Z={Z_1, V_1, N_1}; // 3-bit Z output;
endmodule


module detection_tb();

reg[15:0] a,b;
reg[1:0] op;
wire [2:0] z;
wire [15:0] out;
ALU DUT(a, b, op, out, z);
initial begin
op=2'b00;
a=16'sb0111_1111_1111_1001; //+32761
b=16'sb0111_1111_1111_1010; //+32762
#10;                        //Addition Result: 17'sb0_1111_1111_1111_0011, +65523
                            //Overflow;

a=16'sb1011_1111_1111_1001;//-16391
b=16'sb1011_1111_1111_1010;//-16390
op=2'b00;                  //Addition Result: 17'sb1_0111_1111_1111_0011, -32781
#10;	                   //Overflow  

a=16'sb0111_1111_1111_1001; //+32671
b=16'sb1011_1111_1111_1010; //-16390
op=2'b00;                   // Addition Result: 17'sb1_0001_1111_1111_10011, +16371
#10;                        // No overflow

a=16'sb1011_1111_1111_1101; //-16387
b=16'sb0111_1111_1111_1111; //+32767
op=01;                      //Subtraction Result: 17'sb1_0011_1111_1111_1110, -49154
                            // Overflow
#10;


b=16'sb1011_1111_1111_1101; //-16387
a=16'sb0111_1111_1111_1111; //+32767
op=01;                      //Subtraction Result: 17'sb0_1100_0000_0000_0010, +49154
                            //Overflow
#10;
op=2'b00;                   // No overflow
#10;
op=2'b10;                   // No overflow
#10;
op=2'b11;                   // No overflow
#10;
b=16'sb1111_1111_1111_1111; //-1
a=16'sb0000_0000_0000_0001; //+1
op=00;  
#10; 
end


endmodule
