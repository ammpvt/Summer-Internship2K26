`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 15:55:10
// Design Name: 
// Module Name: ripple_tb
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


module ripple_tb();
reg  [3:0]a_tb;
reg  [3:0]b_tb;
reg cin_tb;
wire [3:0]s_tb;
wire Carry_tb;
ripplecarry4bit dut(a_tb,b_tb,cin_tb,s_tb,Carry_tb);

initial 
begin
    {a_tb,b_tb,cin_tb}=0;
end
initial
begin
        a_tb = 4'b0010; b_tb = 4'b0100; cin_tb = 1'b0;
        #10;
        
        a_tb = 4'b0010; b_tb = 4'b0100; cin_tb = 1'b1;
        #10;
        a_tb = 4'b0101; b_tb = 4'b1010; cin_tb = 1'b0;
        #10;
        a_tb = 4'b1100; b_tb = 4'b0101; cin_tb = 1'b0;
        #10;
        a_tb = 4'b1111; b_tb = 4'b1111; cin_tb = 1'b1;
        #10;
        $monitor("Time=%0dt | A=%b | B=%b | Cin=%b | Sum=%b | Cout=%b", $time, a_tb, b_tb, cin_tb, s_tb, Carry_tb);
end
endmodule
