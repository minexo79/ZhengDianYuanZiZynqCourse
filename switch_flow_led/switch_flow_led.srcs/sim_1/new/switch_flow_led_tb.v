`timescale 1ns/1ns

module switch_flow_led_tb();
    reg             clk;
    reg             rst_n;
    reg     [1:0]   key;
    wire    [3:0]   led;
    
    parameter CLK_PERIOD = 20;  // 20ns
    
    initial begin
        clk = 1'b0; rst_n = 1'b0; key = 2'b11;
        #1 rst_n = 1'b1;
        #10 key = 2'b10;
        #20 key = 2'b01;
        #20 key = 2'b10;
        #20 key = 2'b01;
        #20 key = 2'b11;
        #10 $stop;
    end
    
    always #1 clk = ~clk;
    
    switch_flow_led _led(clk, rst_n, key, led);

endmodule