module pwm_led(
    input           clk,            // System Clock 50MHz
    input           rst_n,          // Reset Button
    output reg      led             // Led Output
    );
    
    parameter _2US  = 7'd100;
    parameter _2MS  = 10'd1_000;
    parameter _2S   = 10'd1_000;
    
    reg     [7:0]   cnt_2us;
    reg     [11:0]  cnt_2ms;
    reg     [11:0]  cnt_2s;
    
    reg     led_flag;
    
    // counter 2us
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt_2us <= 7'd0;
        else if (cnt_2us == _2US - 7'b1)
            cnt_2us <= 7'd0;
        else 
            cnt_2us <= cnt_2us + 7'd1;
    end
    
    // counter 2ms (wait us == period - 1)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt_2ms <= 10'd0;
        else if ((cnt_2ms == _2MS - 10'b1) && (cnt_2us == _2US - 7'b1))
            cnt_2ms <= 10'd0;
        else if (cnt_2us == _2US - 10'b1)    
            cnt_2ms <= cnt_2ms + 10'd1;
    end
    
    // counter 2s (wait ms & us == period - 1)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            cnt_2s <= 10'd0;
        else if ((cnt_2s == _2S - 10'b1) && (cnt_2ms == _2MS - 10'b1) && (cnt_2us == _2US - 7'b1))
            cnt_2s <= 10'd0;
        else if ((cnt_2ms == _2MS - 10'b1) && (cnt_2us == _2US - 10'b1))
            cnt_2s <= cnt_2s + 10'd1;
    end
    
    // led flag
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            led_flag <= 1'b0;
        else if ((cnt_2s == _2S - 10'b1) && (cnt_2ms == _2MS - 10'b1) && (cnt_2us == _2US - 7'b1))
            led_flag <= ~led_flag;
        else
            led_flag <= led_flag;  
    end
    
    // led
    // compare two counters
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            led <= 1'd0;
        else if (led_flag == 1'b0 && cnt_2ms <= cnt_2s) begin       // 0 ~ 2s : Lights Up 
            led <= 1'b1;
        end else if (led_flag == 1'b1 && cnt_2ms >= cnt_2s) begin   // 2 ~ 4s : Lights Down 
            led <= 1'b1;  
        end else
            led <= 1'd0;
    end
//    always @(posedge clk or negedge rst_n) begin
//        if (!rst_n)
//            led <= 1'd0;
//        else if (led_flag == 1'b0) begin
//            if (cnt_2ms <= cnt_2s)  
//                led <= 1'b1;
//            else
//                led <= 1'b0;    
//        end else if (led_flag == 1'b1) begin
//            if (cnt_2ms <= cnt_2s)
//                led <= 1'b0;
//            else
//                led <= 1'b1;  
//        end else
//            led <= led;
//    end
    
    ila_0 ila (
        .clk(clk),          // input wire clk

        .probe0(rst_n),     // input wire [0:0]  probe0  
        .probe1(led),       // input wire [0:0]  probe1 
        .probe2(cnt_2us),   // input wire [7:0]  probe2 
        .probe3(cnt_2ms),   // input wire [11:0]  probe3 
        .probe4(cnt_2s),    // input wire [11:0]  probe4 
        .probe5(led_flag)   // input wire [0:0]  probe5
    );
        
endmodule
