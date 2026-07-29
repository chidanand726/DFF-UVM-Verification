import uvm_pkg::*;
`include "uvm_macros.svh"

class dff_monitor extends uvm_component;

    `uvm_component_utils(dff_monitor)

    // Virtual Interface
    virtual dff_if vif;

    // Analysis Port
    uvm_analysis_port #(dff_txn) mon_ap;

    // Transaction Handle
    dff_txn tx;

    // Coverage Variables
    bit d_cov;
    bit q_cov;
    bit rst_cov;

    // Functional Coverage
    covergroup dff_cg;
        option.per_instance = 1;
        option.name = "DFF_Functional_Coverage";

    // Reset Coverage
    cp_rst : coverpoint rst_cov
    {
        bins reset_asserted   = {0};
        bins reset_deasserted = {1};
    }

    // D Input Coverage
    cp_d : coverpoint d_cov
    {
        bins d_zero = {0};
        bins d_one  = {1};
    }

    // Q Output Coverage
    cp_q : coverpoint q_cov
    {
        bins q_zero = {0};
        bins q_one  = {1};
    }

    // Cross Coverage: D and Q
    d_q_cross : cross cp_d, cp_q
    {
        bins d0_q0 = binsof(cp_d.d_zero) && binsof(cp_q.q_zero);
        bins d0_q1 = binsof(cp_d.d_zero) && binsof(cp_q.q_one);
        bins d1_q0 = binsof(cp_d.d_one)  && binsof(cp_q.q_zero);
        bins d1_q1 = binsof(cp_d.d_one)  && binsof(cp_q.q_one);
    }

    // Cross Coverage: Reset and D
    rst_d_cross : cross cp_rst, cp_d
    {
        bins rst0_d0 = binsof(cp_rst.reset_asserted) && binsof(cp_d.d_zero);

        bins rst0_d1 = binsof(cp_rst.reset_asserted) && binsof(cp_d.d_one);

        bins rst1_d0 = binsof(cp_rst.reset_deasserted) && binsof(cp_d.d_zero);

        bins rst1_d1 = binsof(cp_rst.reset_deasserted) && binsof(cp_d.d_one);
    }

    endgroup

    // Constructor
    function new(string name = "dff_monitor",uvm_component parent = null);
        super.new(name, parent);
        mon_ap = new("mon_ap", this);
        // Create covergroup
        dff_cg = new();
    endfunction

    // Build Phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual dff_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual Interface Not Found")
    endfunction

    // Run Phase
    task run_phase(uvm_phase phase);

        forever begin
            @(vif.mon_cb);
            tx = dff_txn::type_id::create("tx");

            // Sample DUT signals
            tx.d = vif.mon_cb.d;
            tx.q = vif.mon_cb.q;

            // Assign values to coverage variables
            d_cov   = tx.d;
            q_cov   = tx.q;
            rst_cov = vif.mon_cb.rst_n;

            // Sample Functional Coverage
            dff_cg.sample();

            // Send transaction to scoreboard
            mon_ap.write(tx);
            `uvm_info(get_type_name(),$sformatf("MON : D=%0b Q=%0b RST=%0b",tx.d,tx.q,vif.mon_cb.rst_n),UVM_LOW)
        end
    endtask
endclass