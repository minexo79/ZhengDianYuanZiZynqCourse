`timescale 1ns/1ns

module key_switch_led_tb();

    parameter clk_period = 20;      // period 20ns
    
    reg         clk;
    reg         rst_n;
    reg         key;
    
    wire [3:0]  led;

    initial begin
        clk = 1'b0; rst_n = 1'b0;   key = 1'b1;
        #1 rst_n = 1'b1;
        #100 key = 1'b0;         // Key Pressed
        #48 key = 1'b1;
        #22 key = 1'b0; 
        #30 key = 1'b1;
        #25 key = 1'b0; 
        #200000 key = 1'b1;
        #30 key = 1'b0; 
        #22 key = 1'b1;          // Key Released
        #16 key = 1'b0; 
        #20 key = 1'b1;          // Key Released
        #5000000 $stop;
    end
    
    always #(clk_period/2) clk = ~clk; 
    
    top _top(clk, rst_n, key, led);

endmodule