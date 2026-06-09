`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 10:42:12
// Design Name: 
// Module Name: Encoder_4by2_tb
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


module Encoder_4by2_tb();

    reg [3:0] d_tb;
    wire [1:0] b_tb;
    integer m;
    Encoder_4by2 dut(d_tb, b_tb);
    
    initial
    begin
    {d_tb}=0;
    end

initial
begin
for (m=1;m<10;m=m*2)
begin
#10;
{d_tb}=m;
end
end
endmodule
