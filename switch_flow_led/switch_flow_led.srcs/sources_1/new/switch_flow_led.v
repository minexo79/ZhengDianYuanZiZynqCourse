module switch_flow_led(
        input               clk,
        input               rst_n,
        input       [1:0]   key,
        output reg  [3:0]   led
    );
    
    reg [24:0]  cnt;                                // counter
    reg [3:0]   led_flag;                           // led switch flag
    
    // 0.5s  : 25000000
    // 0.25s : 12500000
    // 0.1s  : 5000000
    // ============================================
    // Maxmium Counter Value Count:
    // 1. period_ns = 1 / clk_freq
    // 2. max_cnt_value = delay_ns / period_ns
    parameter  DELAY_VAL = 25'd25000000;
    
    // Counter
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)                                 // rst_n    => reset to zero
            cnt <= 25'd0;
        else if (cnt < (DELAY_VAL - 25'd1))         // normal   => keep add one
            cnt <= cnt + 1'b1;
        else                                        // arrive   => reset to zero
            cnt <= 25'd0;
    end
    
    // Led Switch
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)                                 // rst_n    => reset to zero
            led_flag <= 4'b0001;
        else if (cnt == (DELAY_VAL - 25'd1))        // normal   => switch flag
            led_flag <= {led_flag[2:0], led_flag[3]};
        else                                        // arrive   => reset to zero
            led_flag <= led_flag;
    end
    
    // Led Control
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)                                 // rst_n    => reset to 0000
            led <= 4'b0000;
        else begin
            case(key)
                2'b11:  led <= 4'b0000;             // no key   => reset to 0000
                2'b10:                              // key=10   => led flow L -> R
                    led <= {led_flag[3:0]};
                2'b01:                              // key=01   => led flow R -> L
                    led <= {led_flag[0], led_flag[1], led_flag[2], led_flag[3]};
                default: ;
            endcase
        end
    end
    
endmodule
