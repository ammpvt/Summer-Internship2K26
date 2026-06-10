`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 16:37:14
// Design Name: 
// Module Name: topmodule_tb
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




module topmodule_tb();

    // Testbench signals mapping to top module ports
    reg clk;
    reg rst;
    reg [7:0] p_in;
    
    wire [7:0] p_out;
    wire full;
    wire empty;

    // Instantiate Device Under Test (DUT) by order
    // Order matches: clk, rst, p_in, p_out, full, empty
    Top_module dut (
        clk,
        rst,
        p_in,
        p_out,
        full,
        empty
    );

    // Generate a 100MHz clock (10ns total period, toggles every 5ns)
    always #5 clk = ~clk;

    initial begin
        // --- PHASE 1: INITIALIZATION ---
        clk = 0;
        rst = 1;
        p_in = 8'h00;
        
        // Hold reset for 20ns (2 clock cycles)
        #20;
        p_in = 8'hFF;
        rst = 0;
        #10; // Align to clock boundary

        // --- PHASE 2: TESTING THE 3-CLOCK PIPELINE LAG ---
        // Watch how individual bytes flow into 'p_in' and emerge at 'p_out'
        
        p_in = 8'hA1; #10; // Clock 1: Face module samples hA1
        p_in = 8'hB2; #10; // Clock 2: FIFO stores hA1, Face samples hB2
        p_in = 8'hC3; #10; // Clock 3: FIRST REFLECTION! FSM outputs hA1 on p_out. 
                           //          FIFO stores hB2, Face samples hC3.
                           
        p_in = 8'hD4; #10; // Clock 4: FSM is delaying (DELAY1 state), holding hA1 steady.
        p_in = 8'hE5; #10; // Clock 5: FSM is delaying (DELAY2 state), holding hA1 steady.
        
        p_in = 8'hF6; #10; // Clock 6: SECOND REFLECTION! FSM loops back, outputs hB2.
        
        // --- PHASE 3: TESTING BACKPRESSURE (FIFO FULL) ---
        // Because the face module feeds data 3x faster than the FSM can read it,
        // streaming data continuously will quickly drive the 8-deep FIFO to full.
        
        p_in = 8'h01; #10;
        p_in = 8'h02; #10;
        p_in = 8'h03; #10;
        p_in = 8'h04; #10;
        p_in = 8'h05; #10;
        p_in = 8'h06; #10;
        p_in = 8'h07; #10; // At this point, 'full' wire (ff) should go high!
        
        // Clear input stream and watch the FSM drain the FIFO slowly
        p_in = 8'h00;
        
        // Wait 150ns to observe the slow FSM step through the rest of the stored values
        #150;

        // End simulation
        $finish;
    end

endmodule
