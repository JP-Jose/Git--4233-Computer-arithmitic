module cla #(parameter WIDTH = 14) 
    (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input cin,
    output [WIDTH-1:0] sum,
    output cout
    );

    logic [WIDTH-1:0] g, p;
    logic [WIDTH-1:0] c;

    assign g[0] = a[0] & b[0];
    assign p[0] = a[0] ^ b[0];
    assign c[0] = cin;

    genvar i;
    generate
        for (i = 1; i < WIDTH; i += 3) begin : group
            assign g[i] = a[i] & b[i];
            assign p[i] = a[i] ^ b[i];

            assign g[i+1] = g[i-1] & p[i-1];
            assign p[i+1] = p[i-1] | (g[i-1] & p[i-1]);
            
            assign g[i+2] = g[i] & p[i] & p[i+1];
            assign p[i+2] = p[i] & p[i+1] | (g[i] & p[i+1]) | (g[i+1] & p[i]);

            assign c[i] = g[i] | (p[i] & c[i-1]);
            assign c[i+1] = g[i+1] | (p[i+1] & c[i]);
            assign c[i+2] = g[i+2] | (p[i+2] & c[i+1]);
        end
    endgenerate

    assign sum = a + b + cin;
    assign cout = c[WIDTH-1];

endmodule
