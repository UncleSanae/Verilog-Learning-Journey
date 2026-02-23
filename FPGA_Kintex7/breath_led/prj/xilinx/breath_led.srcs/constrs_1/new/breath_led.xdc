set_property PACKAGE_PIN AE10 [get_ports sys_clk_p]
set_property PACKAGE_PIN AB25 [get_ports sys_rst_n]
set_property PACKAGE_PIN R24 [get_ports led]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
set_property IOSTANDARD LVCMOS33 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports sys_rst_n]

create_clock -period 10.000 -name sys_clk_p [get_ports sys_clk_p]
