 import uvm_pkg::*;
    `include "uvm_macros.svh"

class dff_test extends uvm_test;

    `uvm_component_utils(dff_test)

    dff_env env;

    // Constructor
    function new(string name = "dff_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = dff_env::type_id::create("env", this);
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);

        dff_seq seq;
        super.run_phase(phase);

        // Declare variables FIRST
        // Then start statements
        phase.raise_objection(this);

        seq = dff_seq::type_id::create("seq");
        seq.start(env.agt.seqr);

        #100ns;

        phase.drop_objection(this);
    endtask

endclass

