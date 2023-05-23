module led_switch(
        input               clk,        // System Clock
        input               rst_n,      // Reset
        input               key_filter, // Debounce Key Signal
        output  reg [3:0]   led         // Led Array
    );
    
    parameter  LED_PERIOD = 25'd25_000_000;
    
    reg [24:0]  cnt;
    
    reg         key_filter_d0;
    wire        neg_key_filter;
    
    reg         led_signal;
    
    // generate a raise signal
    assign      neg_key_filter = key_filter_d0 & (~key_filter);
        
    // tap 1 top
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            key_filter_d0 <= 1'b1;
        else
            key_filter_d0 <= key_filter;
    end
    
    // counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt <= 0;
        else if (cnt < LED_PERIOD)
            cnt <= cnt + 25'd1;
        else
            cnt <= 0;
    end
        
    // led signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            led_signal <= 1'b0;
        else if (neg_key_filter)
            led_signal <= ~led_signal;
        else
            led_signal <= led_signal;     
    end
    
    // led
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            led <= 4'b0001;
        else if (cnt == (LED_PERIOD - 25'd1)) 
        begin
            if (led_signal == 1'd0)         // R -> L
                led <= {led[2:0], led[3]};
            else                            // L -> R
                led <= {led[0], led[3:1]};
        end 
        else
            led <= led;
    end
    
endmodule
