module flow_led(
    input               clk,            // System Clock (50MHz)
    input               rst_n,          // System Reset Button (Negative)
    output reg [3:0]    led             // Led Output
    );
    
    reg        [24:0]   cnt;            // Counter
    
    // 0.5s  : 25000000
    // 0.25s : 12500000
    // 0.1s  : 5000000
    // ============================================
    // Maxmium Counter Value Count:
    // 1. period_ns = 1 / clk_freq
    // 2. max_cnt_value = delay_ns / period_ns
    parameter  DELAY_VAL = 25'd12500000;
    
    // Counter
    always @(posedge clk or negedge rst_n) begin
        // rst_n => reset to zero
        if (!rst_n) begin
            cnt <= 25'd0;
        end     
        // normal => keep add one
        else if (cnt < (DELAY_VAL - 25'd1)) begin
            cnt <= cnt + 1'b1;
        end 
        // arrive => reset to zero
        else begin
            cnt <= 25'd0;
        end
    end
    
    // led bitshift operation
    always @(posedge clk or negedge rst_n) begin
        // rst_n => 0001
        if (!rst_n) begin
            led <= 4'b0001;
        end     
        // normal => bitshift
        // high bit move to back, others move to front
        // [1][000] => [000][1]
        else if (cnt == (DELAY_VAL - 25'd1)) begin
            led <= {led[2:0], led[3]};
        end 
        // keep state
        else begin
            led <= led;
        end
    end
    
endmodule
