`timescale 1ns/1ns

module fwc_tb();
    reg     w;
    reg     clk;
    reg     clr;
    wire    z;
        
    parameter clk_period = 20;
    
    integer i;
    
    initial begin
        w = 0; clk = 1; clr = 1;
        #clk_period clr = 0;
        // write 1 and clear using w = 0
        #clk_period w = 1;
        #clk_period w = 0;
        
        // write 2 and clear using clr = 1
        #clk_period w = 1;
        #clk_period w = 1;
        #clk_period clr = 1;
        #clk_period clr = 0;
    
        // write 3 => z = 1
        for(i=0; i<3; i=i+1) begin
            #clk_period w = 1;
        end
        
        #clk_period w = 0;
        
        // write 2 and clear using w = 0
        #clk_period w = 1;
        #clk_period w = 1;
        #clk_period w = 0;      
        
        // write 4 => z = 1
        for(i=0; i<4; i=i+1) begin
            #clk_period w = 1;
        end
        
        // stop
        #clk_period clr = 0;
        #clk_period w = 0;
        #100 $stop;     
    end
    
    always #(clk_period / 2) clk = ~clk;
  
    fwc _fwc(w, clk, clr, z);
  
endmodule