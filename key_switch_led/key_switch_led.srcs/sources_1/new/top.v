module top(
        input               clk,        // System Clock
        input               rst_n,      // Reset
        input               key,        // Key Signal
        output      [3:0]   led         // Led Array
    );
    
    wire key_filter;
    
    debounce_key _key(clk, rst_n, key, key_filter);
    led_switch _led(clk, rst_n, key_filter, led);
    
endmodule
