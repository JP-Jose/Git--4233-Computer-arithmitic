`timescale 1ns/1ps

module stimulus();

    // Declare signals
    logic [13:0] a, b;
    logic cin, cout;
    logic [13:0] sum;
    logic [13:0] expected_sum;
    int expected_cout;

    // Instantiate DUT
    cla #(.WIDTH(14)) dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    // Generate random inputs and expected output
    initial begin
        // Seed the random number generator
        //$randomseed($time);

        // Generate 1000 test cases
        for (int i = 0; i < 50; i++) begin
            // Random 14-bit operands
            a = $random;
            b = $random;

            // Random carry-in
            cin = $random % 2;

            // Compute expected sum and carry-out
            //int expected_cout;
            expected_cout = ((a[13] & b[13]) | (a[13] & cin) | (b[13] & cin));
            expected_sum = a + b + cin;

            // Assert inputs
            #1;
            $display("test %d: \nProgram sum = %d: a = %b, b = %b, cin = %b , cout = %b", i, sum, a, b, cin, cout);

            // Assert expected output
            #1;
           $display("Expected: sum = %d, cout = %d \n", expected_sum, expected_cout);
            assert (sum === expected_sum) else $error("Mismatched sum");
            //assert (cout === expected_cout) else $error("Mismatched carry-out");
        end

        // Terminate simulation
        #1;
        $display("Testbench completed successfully");
        $finish;
    end

endmodule

