// This stest bench will instansiate both the mealy and moore module and get the output
`timescale 1ps/1ps
`include "mealy_1011.v"
`include "moore_1011.v"

module mealy_moore_output_tb;

reg in, clk, rst;
wire mealy_out, moore_out;

mealy_1011 uut_mealy (.in(in),.clk(clk),.rst(rst),.out(mealy_out));
moore_1011 uut_moore (.in(in),.clk(clk),.rst(rst),.out(moore_out));
// Now we first generate a clk signal, here the time period of clock is 10ns
initial begin
    clk = 0;
    forever begin
        #5 clk = ~clk;
    end
end

// Now we write the test bench where we assign the test values 
initial begin
    $dumpfile("mealy_moore_output_tb.vcd");
    $dumpvars(0, mealy_moore_output_tb);
    in=0;
    rst=1;
    #10 rst = 0; // Now reset =0
    // Now I will give a correct sequence

    #10 in = 1;
    #10 in = 0;
    #10 in = 1;
    #10 in = 1;
    // If you see correct sequence was given here 
    // Now I will play with the clock, reset as well as the time 
    #5 rst = 1;
    #5 in = 1;
    #10 in = 0;
    #5 rst = 0;
    #15 in = 1;
    #15 in = 1;
    #5 in = 0;
    #10 in = 1;
    #10 in = 1;

    // Check for overlap 
    #10 in=1; #10 in=0; #10 in=1; #10 in=1; // First '1011' - should detect
    #10 in=0; #10 in=1; #10 in=1;           // Overlapping '1011' - should detect again

    // Negative Test 
    #10 in=0; #10 in=0; #10 in=1; #10 in=0; // Should NOT detect

    // Test reset in middle of sequence
    #10 rst=1; #10 rst=0; // FSM should reset here

    // Test with a noisy start
    #10 in=1; #10 in=1; #10 in=0; #10 in=1; #10 in=1; // '1', '1', then '011' - should detect at end

    // These many cases seem to be alot.

    #20 $finish;

end

// NOw we monitor the signals 
initial begin
    $monitor("in = %b | Clk = %b | reset =%b | mealy_output = %b | moore_output = %b | Time = %0t ", in, clk, rst, mealy_out, moore_out, $time);
end

endmodule 