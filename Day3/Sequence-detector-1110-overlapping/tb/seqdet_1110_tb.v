`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 11:22:25
// Design Name: 
// Module Name: seqdet_1110_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seqdet_1110_tb(

    );
    reg clk_tb,rst_tb,din_tb;
    wire detected_tb;
    
    seq_det_1110_over dut (clk_tb,rst_tb,din_tb,detected_tb);
    initial
     begin
     {clk_tb,rst_tb,din_tb}=0;
    end 
    always #5 clk_tb=~clk_tb;
    initial 
    begin
        rst_tb=1;
        #10;
        rst_tb=0;
        #10;
        
        
        din_tb=1;
        #10;
         din_tb=1;
        #10;
         din_tb=1;
        #10;
         din_tb=0;
        #10; 
        
        
        din_tb=1;
        #10;
         din_tb=1;
        #10;
         din_tb=1;
        #10;
         din_tb=1;
        #10; 
         din_tb=0;
        #10; 
        $finish;
    end
    
endmodule
