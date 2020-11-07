onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lab7_tb/DUT/CPU/clk
add wave -noupdate /lab7_tb/DUT/CPU/reset
add wave -noupdate -divider {PC control}
add wave -noupdate /lab7_tb/DUT/CPU/reset_pc
add wave -noupdate /lab7_tb/DUT/CPU/load_pc
add wave -noupdate /lab7_tb/DUT/CPU/pc/next_pc
add wave -noupdate /lab7_tb/DUT/CPU/addr_sel
add wave -noupdate /lab7_tb/DUT/CPU/PC
add wave -noupdate -divider {CURRENT STATE}
add wave -noupdate /lab7_tb/DUT/CPU/controller/current_state
add wave -noupdate /lab7_tb/DUT/CPU/in
add wave -noupdate -divider {REG FILE}
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R0
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R1
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R2
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R3
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R4
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R5
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R6
add wave -noupdate /lab7_tb/DUT/CPU/DP/REGFILE/R7
add wave -noupdate -divider DP
add wave -noupdate /lab7_tb/DUT/CPU/DP/vsel
add wave -noupdate /lab7_tb/DUT/CPU/DP/mdata
add wave -noupdate /lab7_tb/DUT/CPU/DP/sximm8
add wave -noupdate /lab7_tb/DUT/CPU/DP/sximm5
add wave -noupdate /lab7_tb/DUT/CPU/DP/PC
add wave -noupdate /lab7_tb/DUT/CPU/DP/shift
add wave -noupdate /lab7_tb/DUT/CPU/DP/datapath_out
add wave -noupdate /lab7_tb/DUT/CPU/DP/data_out
add wave -noupdate -divider {Address Control}
add wave -noupdate /lab7_tb/DUT/CPU/mem_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {98 ps} 0}
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
WaveRestoreZoom {72 ps} {155 ps}
