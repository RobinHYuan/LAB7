
module lab7_top(KEY, SW, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
input [3:0] KEY;
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;


wire clk, reset,N, V, Z, w, write;
wire [1:0]  mem_cmd;
wire [7:0]  read_address, write_address;
wire [8:0]  mem_addr, PC;
wire [15:0] read_data, write_data, datapath_out, dout;


RAM #(16,8, "data.txt")MEM     ((~KEY[0]),read_address,write_address,write,write_data,dout);
cpu                    CPU     ((~KEY[0]), (~KEY[1]), read_data, datapath_out, N, V, Z, w, mem_cmd, mem_addr, PC);
read_writeRAM          RW      (mem_addr,mem_cmd,read_data,datapath_out,write_data,dout,(~KEY[0]),read_address,write_address,write);
memorryIO              IO      ((~KEY[0]),mem_addr,mem_cmd,read_data,write_data,SW[7:0],LEDR);


sseg display(PC[3:0],HEX0);
assign HEX1=7'b1111_111;
assign HEX2=7'b1111_111;
assign HEX3=7'b1111_111;
assign HEX4=7'b1111_111;
assign HEX5=7'b1111_111;
endmodule




module sseg(in,segs);
  input [3:0] in;
  output [6:0] segs;
	 reg [6:0] segs;
  // NOTE: The code for sseg below is not complete: You can use your code from
  // Lab4 to fill this in or code from someone else's Lab4.  
  //
  // IMPORTANT:  If you *do* use someone else's Lab4 code for the seven
  // segment display you *need* to state the following three things in
  // a file README.txt that you submit with handin along with this code: 
  //
  //   1.  First and last name of student providing code
  //   2.  Student number of student providing code
  //   3.  Date and time that student provided you their code
  //
  // You must also (obviously!) have the other student's permission to use
  // their code.
  //
  // To do otherwise is considered plagiarism.
  //
  // One bit per segment. On the DE1-SoC a HEX segment is illuminated when
  // the input bit is 0. Bits 6543210 correspond to:
  //
  //    0000
  //   5    1
  //   5    1
  //    6666
  //   4    2
  //   4    2
  //    3333
  //
  // Decimal value | Hexadecimal symbol to render on (one) HEX display
  //             0 | 0
  //             1 | 1
  //             2 | 2
  //             3 | 3
  //             4 | 4
  //             5 | 5
  //             6 | 6
  //             7 | 7
  //             8 | 8
  //             9 | 9
  //            10 | A
  //            11 | b
  //            12 | C
  //            13 | d
  //            14 | E
  //            15 | F

 always@(in)begin
	case(in)
	4'b0_000: segs= 7'b1_000_000; //0
	4'b0_001: segs= 7'b1_111_001; //1
	4'b0_010: segs= 7'b0_100_100; //2
	4'b0_011: segs= 7'b0_110_000; //3
	4'b0_100: segs= 7'b0_011_001; //4
	4'b0_101: segs= 7'b0_010_010; //5
	4'b0_110: segs= 7'b0_000_010; //6
	4'b0_111: segs= 7'b1_111_000; //7 
	4'b1_000: segs= 7'b0_000_000; //8
	4'b1_001: segs= 7'b0_011_000; //9
	4'b1_010: segs= 7'b0_001_000; //A or 10
	4'b1_011: segs= 7'b0_000_011; //b or 11
	4'b1_100: segs= 7'b1_000_110; //c or 12
	4'b1_101: segs= 7'b0_100_001; //d or 13
	4'b1_110: segs= 7'b0_000_110; //E or 14
	4'b1_111: segs= 7'b0_001_110; //F or 15
	default : segs= 7'b1_000_000;
	endcase
  end

endmodule

