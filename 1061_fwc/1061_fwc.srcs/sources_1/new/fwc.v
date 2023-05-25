module fwc(
    input       w,              // input signal
    input       clk,            // clock signal
    input       clr,            // reset signal
    output reg  z               // warning signal
    );
    
    reg [2:0] cnt;
    
    // record input
    always @(posedge clk or posedge clr) begin
        if (clr)
            cnt <= 3'd0;
        else if (w == 1'd0)
            cnt <= 3'd0;
        else begin
            if (cnt == 3'd3)
                cnt <= cnt;
            else
                cnt <= cnt + 3'd1;         
        end
    end
    
    // toggle output
    always @(posedge clk or posedge clr) begin
        if (clr)
            z <= 1'd0;
        else if (cnt == 3'd3)
            z <= 1'd1;
        else
            z <= 1'd0;   
    end
    
endmodule
