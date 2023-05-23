module debounce_key(
        input       clk,                // System Clock
        input       rst_n,              // Reset
        input       key,                // Source Key Signal
        output reg  key_filter          // Debounce Key Signal
    );
    
    parameter   CNT_PERIOD = 20'd1_000_000;
    
    reg         key_d0, key_d1;         // Taps
    reg [19:0]  cnt;                    // Counter (20ms = 1_000_000 => 20 bits)           
    
    // Take 2 Taps For The Key
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            key_d0 <= 1'b1;             // Reset High Signal
            key_d1 <= 1'b1;
        end else begin
            key_d0 <= key;              // Record Key Signal
            key_d1 <= key_d0;           // Record **Previous** key_d0 Signal
        end
    end
    
    // Counter to Identify Key State
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin                       // Rst => Reset To Zero
            cnt <= 20'd0;                      
        end else if (key_d0 != key_d1) begin    // key state Change => Start Counter
            cnt <= CNT_PERIOD;
        end else if (cnt > 20'd0) begin         // counter 20ms
            cnt <= cnt - 20'd1;
        end else begin                          // normal
            cnt <= 20'd0;
        end      
    end
    
    // output key_filter signal
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin                       // Rst => Reset To Zero
            key_filter <= 1'b1;                     
        end else if (cnt == 20'd1) begin        // Count to 20ms => Change key State
            key_filter <= ~key_filter;    
        end else begin                          // Keep Key State
            key_filter <= key_filter;  
        end
    end

endmodule 