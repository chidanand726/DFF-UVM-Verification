`include "uvm_macros.svh"
import uvm_pkg::*;

class dff_driver extends uvm_driver#(dff_txn);
    `uvm_component_utils(dff_driver)

    virtual dff_if vif;

    function new(string name = "dff_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    // Build phase: Get interface from config DB
    function void build_phase(uvm_phase phase);
        if (!uvm_config_db#(virtual dff_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not found! Did you set it in tb_top?")
    endfunction

    // Main driving logic
    task run_phase(uvm_phase phase);
    dff_txn tx;
    vif.drv_cb.d <= 0;
    @(vif.drv_cb);

    forever begin

        seq_item_port.get_next_item(tx);

        vif.drv_cb.d <= tx.d;

        @(vif.drv_cb);

        tx.q = tx.d;

        seq_item_port.item_done();

        `uvm_info(get_type_name(),$sformatf("Driven D=%0b Expected=%0b",tx.d,tx.q),UVM_LOW)

        end

    endtask

endclass

