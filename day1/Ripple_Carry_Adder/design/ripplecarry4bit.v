`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.06.2026 15:38:03
// Design Name: 
// Module Name: ripplecarry4bit
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


module ripplecarry4bit(input [3:0]a,[3:0]b,input cin,output [3:0]s,Cout); 
    wire w1,w2,w3;
    fulladd FA0(a[0],b[0],cin,s[0],w1);
    fulladd FA1(a[1],b[1],w1,s[1],w2);
    fulladd FA2(a[2],b[2],w2,s[2],w3);
    fulladd FA3(a[3],b[3],w3,s[3],Cout);
endmodule
