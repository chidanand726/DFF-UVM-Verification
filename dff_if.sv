interface dff_if(input logic clk);

    logic rst_n;
    logic d;
    logic q;

    // Driver clocking block
    clocking drv_cb @(posedge clk);
        output d;
        output rst_n;
        input q;
    endclocking

    // Monitor clocking block
    clocking mon_cb @(posedge clk);
        default input #1step;
        input d;
        input q;
        input rst_n;
    endclocking

endinterface : dff_if


