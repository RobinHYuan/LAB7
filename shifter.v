module shifter(in, shift, sout);
  input [15:0] in;
  input [1:0] shift;
  output [15:0] sout;

  wire [15:0] a00, a01, a10, a11, in;
  reg [15:0] sout;
  wire [15:0] temp; 
 `define X 16'bxxxx_xxxx_xxxx_xxxx //An undefined 16-bit signal, which should never appear as an output

 /*The following assignments are using conditional operators;
 i.e. If the input signal matches 2'b __, then we shift the in signal to the left/ right (while keeping the MSB); We then assign the shifted siganl to sout.
 */



  assign a00 = in;    //no shift
  assign a01 = in<<1; //left-shift 1 bit, LSB==0
  assign a10 = in>>1; //right-shift 1 bit, MSB==0
  assign temp= in>>1; //temporary bus to store in>>1
  assign a11 = {in[15], temp[14:0]};// concatenate the MSB of in with the rest 14 bits of temp

  always@(*) begin //whenever there is an input
    case(shift)
      2'b00: sout = a00;  //assign the correct outputs due to diffrent shift signal
      2'b01: sout = a01;
      2'b10: sout = a10;
      2'b11: sout = a11;
      default: sout = `X;//default, which should never happen
    endcase
  end

endmodule
