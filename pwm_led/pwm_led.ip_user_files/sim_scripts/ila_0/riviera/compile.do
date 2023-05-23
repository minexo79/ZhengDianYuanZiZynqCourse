transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {D:/XO-PersonalWorkspace/Personal_Project/VivadoWorkspace/pwm_led/pwm_led.cache/compile_simlib/riviera}
vlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../pwm_led.gen/sources_1/ip/ila_0/hdl/verilog" -l xil_defaultlib \
"../../../../pwm_led.gen/sources_1/ip/ila_0/sim/ila_0.v" \


vlog -work xil_defaultlib \
"glbl.v"

