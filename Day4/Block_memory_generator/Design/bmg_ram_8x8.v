`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.06.2026 14:20:19
// Design Name: 
// Module Name: bmg_ram_8x8
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


module bmg_ram_8x8(input clk,rstn,wrenb,
                    input [2:0]wradd,
                    input [2:0]rdadd,
                    input [7:0]data_in,
                    output reg [7:0]data_out
            
    );
    reg [7:0]mem[7:0];
    integer i;
    always@(posedge clk or negedge rstn)
    begin
        if(rstn==0)
        begin 
            data_out <= 8'h0;
            for(i=0;i<8;i=i+1)
            begin 
                mem[i]<=8'h0;
            end 
        end
        else
        begin
            if (wrenb==1)
                mem[wradd]<=data_in; 
            else 
                data_out<=mem[rdadd];
        end    
    end 
    
    
endmodule
