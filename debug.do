onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider RAM
add wave -noupdate /tb/DUT/MEM/data_width
add wave -noupdate /tb/DUT/MEM/addr_width
add wave -noupdate /tb/DUT/MEM/filename
add wave -noupdate /tb/DUT/MEM/clk
add wave -noupdate /tb/DUT/MEM/read_address
add wave -noupdate /tb/DUT/MEM/write_address
add wave -noupdate /tb/DUT/MEM/din
add wave -noupdate /tb/DUT/MEM/write
add wave -noupdate /tb/DUT/MEM/dout
add wave -noupdate /tb/DUT/MEM/mem
add wave -noupdate -divider CPU
add wave -noupdate /tb/DUT/CPU/reset_pc
add wave -noupdate /tb/DUT/CPU/load_pc
add wave -noupdate /tb/DUT/CPU/PC
add wave -noupdate /tb/DUT/CPU/PC_DP
add wave -noupdate /tb/DUT/CPU/mem_addr
add wave -noupdate /tb/DUT/MEM/dout
add wave -noupdate /tb/DUT/CPU/in
add wave -noupdate /tb/DUT/CPU/load_ir
add wave -noupdate /tb/DUT/CPU/instruction_out
add wave -noupdate /tb/DUT/CPU/addr_sel
add wave -noupdate /tb/DUT/CPU/controller/current_state
add wave -noupdate -divider {Address REg}
add wave -noupdate /tb/DUT/CPU/adressREG/datapath_out
add wave -noupdate /tb/DUT/CPU/adressREG/PC
add wave -noupdate /tb/DUT/CPU/adressREG/load_addr
add wave -noupdate /tb/DUT/CPU/adressREG/addr_sel
add wave -noupdate /tb/DUT/CPU/adressREG/clk
add wave -noupdate /tb/DUT/CPU/adressREG/mem_addr
add wave -noupdate /tb/DUT/CPU/adressREG/Data_out
add wave -noupdate -divider REGFILE
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R0
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R1
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R2
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R3
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R4
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R5
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R6
add wave -noupdate /tb/DUT/CPU/DP/REGFILE/R7
add wave -noupdate -divider {Instruction Reg}
add wave -noupdate /tb/DUT/CPU/instructionReg/in
add wave -noupdate /tb/DUT/CPU/instructionReg/load
add wave -noupdate /tb/DUT/CPU/instructionReg/clk
add wave -noupdate /tb/DUT/CPU/instructionReg/muxOut
add wave -noupdate -divider {PC REG}
add wave -noupdate /tb/DUT/CPU/pc/reset_pc
add wave -noupdate /tb/DUT/CPU/pc/load_pc
add wave -noupdate /tb/DUT/CPU/pc/clk
add wave -noupdate /tb/DUT/CPU/pc/PC
add wave -noupdate /tb/DUT/CPU/pc/next_pc
add wave -noupdate /tb/DUT/CPU/pc/pc_reg/in
add wave -noupdate -divider {PC reg}
add wave -noupdate /tb/DUT/CPU/pc/pc_reg/load
add wave -noupdate /tb/DUT/CPU/pc/pc_reg/clk
add wave -noupdate /tb/DUT/CPU/pc/pc_reg/out
add wave -noupdate /tb/DUT/CPU/pc/pc_reg/muxOut
add wave -noupdate /tb/DUT/CPU/pc/pc_reg/in
add wave -noupdate -divider {CPU output}
add wave -noupdate /tb/DUT/CPU/N
add wave -noupdate /tb/DUT/CPU/V
add wave -noupdate /tb/DUT/CPU/Z
add wave -noupdate /tb/DUT/CPU/w
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {626 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 268
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {614 ps} {697 ps}
