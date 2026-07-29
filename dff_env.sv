  import uvm_pkg::*;
    `include "uvm_macros.svh";

class dff_env extends uvm_env;

    `uvm_component_utils(dff_env)

    // Contained components
    dff_agent       agt;
    dff_scoreboard  sb;

    // Constructor
    function new(string name = "dff_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase: create agent and scoreboard
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = dff_agent::type_id::create("agt", this);
        sb  = dff_scoreboard::type_id::create("sb", this);
    endfunction
//started in the vs code
    // Connect phase: connect monitor?s analysis port to scoreboard
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        agt.mon.mon_ap.connect(sb.sb_imp);
    endfunction

endclass

