# Clock
create_clock -period 20.000 -name clk_50 [get_ports clk]
set_property PACKAGE_PIN N18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# BTN
set_property PACKAGE_PIN T12 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

# LED
set_property PACKAGE_PIN V15 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports led]
