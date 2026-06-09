`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 16:22:06
// Design Name: 
// Module Name: BCDadder
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


module BCDadder (
    input [3:0] A, [3:0] B, 
    input CIN,
    output [3:0] S, 
    output COUT);
    wire [3:0] sumout1;
    wire cout1;
    wire w1, w2, w3;
    wire [3:0] temp;
    wire dontcare;
    
    ripplecarry4bit RC0(A, B, CIN, sumout1, cout1);
    and (w1, sumout1[3], sumout1[2]);
    and (w2, sumout1[3], sumout1[1]);
    or  (w3, w1, w2);
    or  (COUT, cout1, w3);
    assign temp = {1'b0, COUT, COUT, 1'b0};
    ripplecarry4bit RC1(sumout1, temp, 1'b0, S, dontcare);
     
endmodule
