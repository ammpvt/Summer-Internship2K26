`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 16:37:32
// Design Name: 
// Module Name: fifo_tb_inf
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
interface fifo();
    logic clk;
    logic rst;
    logic wrenb;
    logic rdenb;
    logic [7:0] data_in;
    logic [7:0] data_out;
    logic full;
    logic empty;
    
endinterface
module fifo_tb_inf();
    fifo inf();
    FIFO dut(inf.clk,inf.rst,inf.wrenb,inf.rdenb,inf.data_in,inf.data_out,inf.full,inf.empty);
    always #5 inf.clk=~inf.clk;

initial begin 
    inf.clk   = 0; 
        inf.wrenb = 0; 
        inf.rdenb = 0; 
    inf.rst=1;
    #10;
    inf.rst=0;
    #10;
    
    inf.wrenb = 1;                 
    inf.data_in = 8'hAA; #10;    
    inf.data_in = 8'hBB; #10;      
    inf.data_in = 8'hCC; #10;      
    inf.wrenb = 0;                 
    #20;

    inf.rdenb = 1;                
    #20;                          
    inf.rdenb = 0;                
    #20;
        
    inf.wrenb = 1;
    inf.data_in= 8'h01; #10;
    inf.data_in= 8'h02; #10;
    inf.data_in= 8'h03; #10;
    inf.data_in = 8'h04; #10;
    inf.data_in= 8'h05; #10;
    inf.data_in = 8'h06; #10;
    inf.data_in = 8'h07; #10;
    inf.wrenb = 0;
    #20;
        
    inf.rdenb = 1;
    #80;                       
    inf.rdenb = 0;
    #20;
    $finish;    
end 
endmodule
