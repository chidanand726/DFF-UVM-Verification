`timescale 1ns/1ps
`include "uvm_macros.svh"
import uvm_pkg::*;

import dff_pkg::*;

// Top-Level Testbench Module
module dff_top;

    // Clock signal
    logic clk;
 
    // Instantiate interface and connect to clock
    dff_if dff_vif (clk);

    // DUT instance
    dff dut (
        .clk   (clk),
        .rst_n (dff_vif.rst_n),
        .d     (dff_vif.d),
        .q     (dff_vif.q)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Reset generation
    initial begin
        dff_vif.rst_n = 0;
        #15;
        dff_vif.rst_n = 1;
    end

    // UVM Configuration and Test Start
    initial begin
        // Set virtual interface for driver and monitor
        uvm_config_db#(virtual dff_if)::set(null, "*", "vif", dff_vif);

        // Run the UVM test
        run_test("dff_test");
    end

endmodule

