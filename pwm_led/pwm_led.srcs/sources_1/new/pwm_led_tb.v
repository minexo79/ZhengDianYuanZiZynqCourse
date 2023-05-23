`timescale 1ns/1ns

module pwm_led_tb();
    reg             clk;
    reg             rst_n;
    wire            led;
    
    parameter CLK_PERIOD = 20;  // 20ns
    
    initial begin
        clk = 1'b0; rst_n = 1'b0;
        #1 rst_n = 1'b1;
        #50000000 $stop;
    end
    
    always #1 clk = ~clk;
    
    pwm_led _led(clk, rst_n, led);

endmodule