`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 16:00:29
// Design Name: 
// Module Name: universal_tb
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


module universal_tb(
);
    reg clk,rst,sin;
    reg [3:0] pin;
    reg shift,load;
    reg [1:0] mod;
    wire sout;
    wire [3:0] pout;

universal dut (clk,rst,sin,shift,load,mod,pin,sout,pout
                    );    
    initial 
    begin
        {clk,rst,sin,shift,load,mod,pin}=0;
    end
    always#5 clk=~clk;
    initial begin
        clk = 0;
        rst = 1;
        sin = 0;
        pin = 4'b0000;
        shift = 0;
        load = 0;
        mod = 2'b00;
        #10;
        sin = 1;
        #20;
        sin = 0;
        #70;
        rst = 0;
        load = 1;

        mod = 2'b11;
        pin = 4'b1010;
        #10;

        mod = 2'b10;
        pin = 4'b1101;
        shift = 0; 
        #10;
        shift = 1; 
        #40;       

        mod = 2'b01;
        shift = 1;
        sin = 1; #10;
        sin = 0; #10;
        sin = 1; #10;
        sin = 1; #10;

        mod = 2'b00;
        shift = 1;
        sin = 0; #10;
        sin = 1; #10;
        sin = 0; #10;
        sin = 0; #10;

        #20;
        load = 0;
        #20;
        end
endmodule
