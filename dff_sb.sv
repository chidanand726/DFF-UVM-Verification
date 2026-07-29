  import uvm_pkg::*;
    `include "uvm_macros.svh"

class dff_scoreboard extends uvm_component;

    `uvm_component_utils(dff_scoreboard)

    // Analysis imp to receive data from monitor
    uvm_analysis_imp#(dff_txn, dff_scoreboard) sb_imp;

    // For logging and debugging
    int total_txns;
    int pass_count, fail_count;
    bit expected_q;
    bit first_sample = 1;

    // Constructor
    function new(string name = "dff_scoreboard", uvm_component parent = null);
        super.new(name, parent);
        sb_imp = new("sb_imp", this);
    endfunction

    // The write() method is called whenever monitor sends a transaction
  function void write(dff_txn tx);

    total_txns++;

    if (first_sample) begin
        expected_q = tx.d;
        first_sample = 0;

        pass_count++;
        `uvm_info(get_type_name(),$sformatf("PASS (Initial): D=%0b Q=%0b",tx.d, tx.q),UVM_LOW)
        return;
    end

    if (tx.q === expected_q) begin
        pass_count++;
        `uvm_info(get_type_name(),$sformatf("PASS : Expected Q=%0b Actual Q=%0b",expected_q, tx.q),UVM_LOW)
    end
    else begin
        fail_count++;
        `uvm_error(get_type_name(),$sformatf("FAIL : Expected Q=%0b Actual Q=%0b",expected_q, tx.q))
    end

    // Store current D for the next clock cycle
    expected_q = tx.d;

  endfunction

    // Report phase to summarize results
    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(),$sformatf("Total = %0d, Pass = %0d, Fail = %0d",total_txns, pass_count, fail_count),UVM_NONE)
    endfunction

endclass

