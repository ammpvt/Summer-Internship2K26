`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 15:05:14
// Design Name: 
// Module Name: bmg_ram_tb
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


module bmg_ram_tb();
    reg clk_tb,rstn_tb,wrenb_tb;
    reg [2:0]wradd_tb;
    reg [2:0]rdadd_tb;
    reg [7:0]data_in_tb;
    wire [7:0]data_out_tb;
    
    bmg_ram_8x8 dut (clk_tb,rstn_tb,wrenb_tb,wradd_tb,rdadd_tb,data_in_tb,data_out_tb);
    initial begin 
        {clk_tb,rstn_tb,wrenb_tb,wradd_tb,rdadd_tb,data_in_tb}=0;
    end
        always #5 clk_tb = ~clk_tb;
    initial
begin
        #15;
        rstn_tb = 1;
        wrenb_tb = 1;
        #10;
        
         wradd_tb = 8'h05;      
        data_in_tb = 8'b10111001; 
        #10;
        wradd_tb = 8'h03;      
        data_in_tb = 8'b10111011; 
        #10;
        wrenb_tb=0;
        rdadd_tb = 8'h05;   
        #10;
        rdadd_tb = 8'h03;     
        #20;
        $finish;
end            

endmodule
