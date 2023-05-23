`timescale 1ns / 1ns

module flow_led_tb();
    reg         clk;
    reg         rst_n;
    wire [3:0]  led;
   
    flow_led _led(clk, rst_n, led);     
   
    initial begin
        clk = 1'b1; rst_n = 1'b0;
        #5 
        rst_n = 1'b1;
    end
   
    always #1  clk = ~clk;
    
endmodule