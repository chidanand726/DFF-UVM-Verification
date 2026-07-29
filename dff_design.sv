module dff (
    input  logic clk,      // Clock
    input  logic rst_n,    // Active-low synchronous reset
    input  logic d,        // D input
    output logic q         // Q output
    );

    // Sequential logic: Q follows D on rising clock edge
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;     // Reset output to 0
        else
            q <= d;        // Capture input D
    end

endmodule
