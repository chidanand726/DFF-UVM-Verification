  import uvm_pkg::*;
    `include "uvm_macros.svh"

class dff_sequencer extends uvm_sequencer#(dff_txn);
    
    `uvm_component_utils(dff_sequencer)

    // Constructor
    function new(string name = "dff_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction

endclass

