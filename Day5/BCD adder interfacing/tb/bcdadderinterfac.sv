`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 22:39:00
// Design Name: 
// Module Name: bcdadderinterfac
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


interface bcd_if;
    logic [3:0] A;
    logic [3:0] B;
    logic       CIN;
    logic [3:0] S;
    logic       COUT;
endinterface

module bcdadderinterfac;
    bcd_if inf();

    BCDadder dut(inf.A, inf.B, inf.CIN, inf.S, inf.COUT);

    initial begin
        {inf.A, inf.B, inf.CIN} = 0;
    end

    initial begin
        inf.A = 4'b0000; inf.B = 4'b0000; inf.CIN = 1'b0;
        #50;
        inf.A = 4'b0010; inf.B = 4'b0011; inf.CIN = 1'b0;
        #50;
        inf.A = 4'b0101; inf.B = 4'b0100; inf.CIN = 1'b0;
        #50;
        inf.A = 4'b0110; inf.B = 4'b0111; inf.CIN = 1'b0;
        #50;
        inf.A = 4'b1000; inf.B = 4'b1000; inf.CIN = 1'b0;
        #50; 

        $monitor("The value of a_tb is %b The value of b_tb is %b The value of c_tb is %b The value of sum_tb is %b The value of cout_tb is %b ", inf.A, inf.B, inf.CIN, inf.S, inf.COUT);
    end
endmodule