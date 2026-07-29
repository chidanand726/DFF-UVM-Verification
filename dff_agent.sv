  import uvm_pkg::*;
    `include "uvm_macros.svh"

class dff_agent extends uvm_agent;

    `uvm_component_utils(dff_agent)

    // Agent sub-components
    dff_driver     drv;
    dff_monitor    mon;
    dff_sequencer  seqr;

    // Virtual interface
    virtual dff_if vif;

    // Constructor
    function new(string name = "dff_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase: Create components and get virtual interface
    function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual dff_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found! Did you set it in tb_top?")

        // Create components
        drv  = dff_driver::type_id::create("drv", this);
        mon  = dff_monitor::type_id::create("mon", this);
        seqr = dff_sequencer::type_id::create("seqr", this);
    endfunction

    // Connect phase: Connect driver to sequencer and provide interface
    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);

        // Pass virtual interface to sub-components
        drv.vif = vif;
        mon.vif = vif;
    endfunction

endclass
