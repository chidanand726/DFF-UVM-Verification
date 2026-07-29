`include "uvm_macros.svh";
import uvm_pkg::*;

class dff_seq extends uvm_sequence#(dff_txn);
    `uvm_object_utils(dff_seq)

    function new(string name = "dff_seq");
        super.new(name);
    endfunction

    task body();
        dff_txn tx;
        `uvm_info(get_type_name(), "Starting DFF sequence...", UVM_LOW)

        repeat (10) begin
            tx = dff_txn::type_id::create("tx");
            assert(tx.randomize()); 
            start_item(tx);         
            finish_item(tx);        
            `uvm_info(get_type_name(), $sformatf("Generated txn: %s", tx.convert2string()), UVM_LOW)
        end

        `uvm_info(get_type_name(), "DFF sequence completed.", UVM_LOW)
    endtask

endclass

