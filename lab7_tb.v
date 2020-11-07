module lab7_tb1();
  reg [3:0] KEY;
  reg [9:0] SW;
  wire [9:0] LEDR; 
  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  reg err;

  lab7_top DUT(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
   //Here Key 0 is clk and Key 1 is reset
  initial forever begin
    KEY[0] = 1; #5;
    KEY[0] = 0; #5;
  end

initial begin
    err=0;
    KEY[1]=0; // RESET 
    #10;
    KEY[1]=1;

    // check memory
    if (DUT.MEM.mem[0] !== 16'b1101000000000101) begin err = 1; $display("FAILED: mem[0] wrong; please set data.txt using Figure 6"); $stop; end
    if (DUT.MEM.mem[1] !== 16'b0110000000111111) begin err = 1; $display("FAILED: mem[1] wrong; please set data.txt using Figure 6"); $stop; end
    if (DUT.MEM.mem[2] !== 16'b1101001000000110) begin err = 1; $display("FAILED: mem[2] wrong; please set data.txt using Figure 6"); $stop; end
    if (DUT.MEM.mem[3] !== 16'b1000001000100000) begin err = 1; $display("FAILED: mem[3] wrong; please set data.txt using Figure 6"); $stop; end
    if (DUT.MEM.mem[4] !== 16'b1110000000000000) begin err = 1; $display("FAILED: mem[4] wrong; please set data.txt using Figure 6"); $stop; end
    if (DUT.MEM.mem[5] !== 16'b1010101111001101) begin err = 1; $display("FAILED: mem[4] wrong; please set data.txt using Figure 6"); $stop; end
    //check PC
     if (DUT.CPU.reset_pc !== 1) begin err = 1; $display("FAILED  to reset PC "); $stop; end
     if (DUT.CPU.pc.next_pc !== 0) begin err = 1; $display("FAILED  initialize next PC "); $stop; end
     #10;
     if (DUT.CPU.PC !== 0) begin err = 1; $display("FAILED:PC failed to initialize "); $stop; end
     if (DUT.CPU.addr_sel !== 1) begin err = 1; $display("FAILED to select the correct address "); $stop; end
     if (DUT.CPU.mem_addr !== 0) begin err = 1; $display("FAILED to select the correct address "); $stop; end
     if (DUT.CPU.mem_cmd !== 2'b10) begin err = 1; $display("FAILED to read the correct address "); $stop; end
     #10;
     if (DUT.CPU.in !== 16'b1101000000000101 )begin err = 1; $display("FAILED to recieve the correct instruction"); $stop; end
     #10;
     if (DUT.CPU.instruction_out !== 16'b1101000000000101 )begin err = 1; $display("FAILED to store the correct instruction"); $stop; end
     #10;
     if (DUT.CPU.PC !== 1) begin err = 1; $display("FAILED:PC failed to update"); $stop; end
     #30;// WAIT TILL STATE IS IF1
     if (DUT.CPU.DP.REGFILE.R0 !== 16'h5) begin err = 1; $display("FAILED: R0 should be 5."); $stop; end  // because MOV R0, X should have occurred
     #10;
     if (DUT.CPU.in !== 16'b0110000000111111 )begin err = 1; $display("FAILED to recieve the correct instruction"); $stop; end
     #10;
     if (DUT.CPU.load_pc !== 1) begin err = 1; $display("FAILED  to load PC "); $stop; end
     if (DUT.CPU.instruction_out !==  16'b0110000000111111 )begin err = 1; $display("FAILED to store the correct instruction"); $stop; end
     #10;//decode
      if (DUT.CPU.PC !== 9'h2) begin err = 1; $display("FAILED:PC failed to update"); $stop; end
     #10;//LDR1
      if(DUT.CPU.DP.loada!=1) begin err = 1; $display("FAILED to load REG A"); $stop; end
     #10;
     #10;
      if(DUT.CPU.DP.datapath_out!=16'h4) begin err = 1; $display("FAILED to output the correct result"); $stop; end
     #10;
      if (DUT.CPU.mem_addr !== 9'h4) begin err = 1; $display("FAILED to select the correct address "); $stop; end
      if (DUT.CPU.mem_cmd !== 2'b10) begin err = 1; $display("FAILED to read the correct address "); $stop; end
     #10;
      if(DUT.CPU.DP.mdata!=16'b1110000000000000) begin err = 1; $display("FAILED to output the correct mdata"); $stop; end
     #10;
      if (DUT.CPU.DP.REGFILE.R1 !== 16'b1110000000000000 ) begin err = 1; $display("FAILED: R1 should be 16'b1110000000000000."); $stop; end 
     #10;
      if (DUT.CPU.in !== 16'b1101001000000110 )begin err = 1; $display("FAILED to recieve the correct instruction"); $stop; end
     #10;
      if (DUT.CPU.instruction_out !== 16'b1101001000000110 )begin err = 1; $display("FAILED to store the correct instruction"); $stop; end
     #10;
      if (DUT.CPU.PC !== 9'h3) begin err = 1; $display("FAILED:PC failed to update"); $stop; end
     #30;
      if (DUT.CPU.DP.REGFILE.R2 !== 16'h6) begin err = 1; $display("FAILED: R2 should be 6."); $stop; end 
     #10;
     if (DUT.CPU.in !== 16'b1000001000100000 )begin err = 1; $display("FAILED to recieve the correct instruction"); $stop; end
     #10;
     if (DUT.CPU.instruction_out !==  16'b1000001000100000 )begin err = 1; $display("FAILED to store the correct instruction"); $stop; end
     #10;
      if (DUT.CPU.PC !== 9'h4) begin err = 1; $display("FAILED:PC failed to update"); $stop; end
     #10;
     if(DUT.CPU.DP.loada!=1) begin err = 1; $display("FAILED to load REG A"); $stop; end
     #10;
     #10;
      if(DUT.CPU.DP.datapath_out!=16'h6) begin err = 1; $display("FAILED to output the correct result"); $stop; end
     #10;
      if (DUT.CPU.mem_addr !== 9'h6) begin err = 1; $display("FAILED to select the correct address "); $stop; end
      if (DUT.CPU.load_addr !== 0) begin err = 1; $display("FAILED to load the correct address "); $stop; end
      if(DUT.CPU.DP.loadb!=1) begin err = 1; $display("FAILED to load REG B"); $stop; end
     #20;
      if(DUT.CPU.DP.datapath_out!= 16'b1110000000000000) begin err = 1; $display("FAILED to output the correct result"); $stop; end
      if (DUT.CPU.mem_addr !== 9'h6) begin err = 1; $display("FAILED to select the correct address "); $stop; end
      if (DUT.CPU.mem_cmd !== 2'b01) begin err = 1; $display("FAILED to read the correct address "); $stop; end
      if (DUT.IO.write_data !== 16'b1110000000000000) begin err = 1; $display("FAILED to provide the correct input "); $stop; end
     #10;
      if (DUT.MEM.mem[6] !== 16'b1110000000000000) begin err = 1; $display("FAILED to write data into mem[6]"); $stop; end
     #10;
      if (DUT.CPU.in !==16'b1110000000000000 )begin err = 1; $display("FAILED to recieve the correct instruction"); $stop; end
     #20;
     if (DUT.CPU.PC !== 9'h5) begin err = 1; $display("FAILED:PC failed to update"); $stop; end
     #10;
     if (DUT.CPU.controller.current_state !== 6'b01_1100) begin err = 1; $display("FAILED to update state "); $stop; end
     #100;
    if (DUT.CPU.PC !== 9'h5) begin err = 1; $display("HALT FAILED"); $stop; end
    if (DUT.CPU.controller.current_state !== 6'b01_1100) begin err = 1; $display("HALT FAILED  "); $stop; end
    KEY[1]=0; // RESET 
     #10;
    if (DUT.CPU.controller.current_state !== 6'b00_0000) begin err = 1; $display("HALT FAILED  "); $stop; end
    if(err==0) $display ("PASSED");
     $stop;
end 
endmodule 



module lab7_tb_2();

  reg [3:0] KEY;
  reg [9:0] SW;
  wire [9:0] LEDR; 
  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  reg err;

  lab7_top DUT(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
   //Here Key 0 is clk and Key 1 is reset
  initial forever begin
    KEY[0] = 1; #5;
    KEY[0] = 0; #5;
  end

initial begin
    err=0;
    KEY[1]=0; // RESET 
    #10;
    KEY[1]=1;

    SW=9'b0_1101_1000;

    if (DUT.MEM.mem[0] !== 16'b1101000000001000) begin err = 1; $display("FAILED: mem[0] wrong; "); $stop; end
    if (DUT.MEM.mem[1] !== 16'b0110000000000000) begin err = 1; $display("FAILED: mem[1] wrong; "); $stop; end
    if (DUT.MEM.mem[2] !== 16'b0110000001000000) begin err = 1; $display("FAILED: mem[2] wrong; "); $stop; end
    if (DUT.MEM.mem[3] !== 16'b1100000001101010) begin err = 1; $display("FAILED: mem[3] wrong; "); $stop; end
    if (DUT.MEM.mem[4] !== 16'b1101000100001001) begin err = 1; $display("FAILED: mem[4] wrong; "); $stop; end
    if (DUT.MEM.mem[5] !== 16'b0110000100100000) begin err = 1; $display("FAILED: mem[5] wrong; "); $stop; end
    if (DUT.MEM.mem[6] !== 16'b1000000101100000) begin err = 1; $display("FAILED: mem[6] wrong; "); $stop; end 
    if (DUT.MEM.mem[7] !== 16'b1110000000000000) begin err = 1; $display("FAILED: mem[7] wrong; "); $stop; end 
    if (DUT.MEM.mem[8] !== 16'b0000000101000000) begin err = 1; $display("FAILED: mem[8] wrong; "); $stop; end 
    if (DUT.MEM.mem[9] !== 16'b0000000100000000) begin err = 1; $display("FAILED: mem[9] wrong; "); $stop; end 

    if (DUT.CPU.reset_pc !== 1) begin err = 1; $display("FAILED  to reset PC "); $stop; end
 #10;
 @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
 if (DUT.CPU.PC !== 9'h1) begin err = 1; $display("FAILED: PC should be 1."); $stop; end
 @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
 if (DUT.CPU.PC !== 9'h2) begin err = 1; $display("FAILED: PC should be 2."); $stop; end
 if (DUT.CPU.DP.REGFILE.R0 !== 16'h8) begin err = 1; $display("FAILED: R0 should be 8."); $stop; end
 @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
 if (DUT.CPU.DP.REGFILE.R0 !== 16'h140) begin err = 1; $display("FAILED: R0 should be 0x140."); $stop; end
 if (DUT.CPU.instruction_out !==16'b0110000001000000 )begin err = 1; $display("FAILED to store the correct instruction"); $stop; end
 #40;
 if(DUT.CPU.DP.datapath_out!= 16'h140) begin err = 1; $display("FAILED to output the correct result"); $stop; end
 #10;
 if (DUT.CPU.mem_addr !== 9'h140) begin err = 1; $display("FAILED to select the correct address "); $stop; end
 if (DUT.CPU.load_addr !== 0) begin err = 1; $display("FAILED to load the correct address "); $stop; end
 if (DUT.CPU.mdata!=={{8{1'b0}},{SW[7:0]}})  begin err=1; end
 #20;
 if (DUT.CPU.DP.REGFILE.R2!=={{8{1'b0}},{SW[7:0]}}) begin err = 1; $display("FAILED: R2 should be {{8{1'b0}},{SW[7:0]}}."); $stop; end
 @(DUT.CPU.PC == 9'h5)
 if (DUT.CPU.DP.REGFILE.R3!=={{7{1'b0}},{SW[7:0]}, 1'b0}) begin err = 1; $display("FAILED: R0 should be 8."); $stop; end
 @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
 if(DUT.CPU.DP.REGFILE.R1!==16'h9) begin err = 1; $display("FAILED: R1 should be 9."); $stop; end
 @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
 if(DUT.CPU.DP.REGFILE.R1!==16'h0100) begin err = 1; $display("FAILED: R0 should be 0x0100."); $stop; end
 @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
 if(LEDR[7:0]!==DUT.CPU.DP.REGFILE.R3[7:0]) begin err = 1; $display("FAILED"); $stop; end
 #100;
 if (DUT.CPU.controller.current_state !== 6'b01_1100) begin err = 1; $display("HALT FAILED  "); $stop; end
$stop;

end

endmodule 


module lab7_tb();

  reg [3:0] KEY;
  reg [9:0] SW;
  wire [9:0] LEDR; 
  wire [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
  reg err;

  lab7_top DUT(KEY,SW,LEDR,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
   //Here Key 0 is clk and Key 1 is reset
  initial forever begin
    KEY[0] = 1; #5;
    KEY[0] = 0; #5;
  end

initial begin
    err=0;
    KEY[1]=0; // RESET 
    #10;
    KEY[1]=1;
   SW=9'b0_1101_1000;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
   #10;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
   #10;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
	if (DUT.CPU.DP.REGFILE.R1 !== 16'h7) err=1;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R0 !== 16'd15) err=1;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.N!== 1) err=1;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R0 !== 16'h140) begin err = 1; $display("FAILED: R0."); $stop; end
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
          if (DUT.CPU.DP.REGFILE.R3!=={{8{1'b0}},{SW[7:0]}}) begin err = 1; $display("FAILED: R3."); $stop; end 
     SW=9'b1_1111_1111;
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
          if (DUT.CPU.DP.REGFILE.R4!=={{8{1'b0}},{SW[7:0]}}) begin err = 1; $display("FAILED: R4."); $stop; end 
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R7 !== 16'd16) begin err = 1; $display("FAILED: R7."); $stop; end
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R7 !== 16'h0100) begin err = 1; $display("FAILED: R7."); $stop; end
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.LEDR !== {{2{1'b0}},{SW[7:0]}}) begin err = 1; $display("FAILED: LEDR"); $stop; end
   @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.LEDR !== 10'h7) begin err = 1; $display("FAILED: LEDR"); $stop; end
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R5 !== 16'd517) begin err = 1; $display("FAILED: R5."); $stop; end
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R6 !== 16'd0) begin err = 1; $display("FAILED: R6."); $stop; end
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R2 !== 16'b1111_11101_1111_1010) begin err = 1; $display("FAILED: R2"); $stop; end
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.CPU.DP.REGFILE.R7 !== 16'b1000011110000000) begin err = 1; $display("FAILED: R7"); $stop; end
    @(posedge DUT.CPU.PC or negedge DUT.CPU.PC);
        if (DUT.MEM.mem[0] !== 16'd517) begin err = 1; $display("FAILED: mem[0] wrong; "); $stop; end
     $stop;
end 
endmodule
