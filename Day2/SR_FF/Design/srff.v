`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 12:22:58
// Design Name: 
// Module Name: srff
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


module srff(input s,r,rst,clk,output reg q,qbar 

    );
    
    always@(*)
    begin 
     if(rst)
        begin
            q<=1'b0;
            qbar<=1'b1;
        end
    end
    
        always@(posedge clk)
    begin
        
     if(s==0&r==0)
        begin
            q<=q;
            qbar<=qbar;
        end  
     else if(s==0&r==1)
        begin
            q<=1'b0;
            qbar<=1'b1;
        end 
      else if(s==1&r==0)
        begin
            q<=1'b0;
            qbar<=1'b1;
        end     
         else if(s==1&r==1)
        begin
            q<='bx;
            qbar<='bx;
        end 
    end
endmodule
