//`include "dff_txn.sv"
  import uvm_pkg::*;
    `include "uvm_macros.svh";


class dff_seq extends uvm_sequence#(dff_txn);

    `uvm_object_utils(dff_seq)

    // Constructor
    function new(string name = "dff_seq");
        super.new(name);
    endfunction

    // Main sequence body
    task body();
        dff_txn tx;

        `uvm_info(get_type_name(), "Starting DFF sequence...", UVM_LOW)

        // Generate 10 random transactions for example
        repeat (10) begin
            tx = dff_txn::type_id::create("tx");
            assert(tx.randomize()); // Randomize 'd'
            start_item(tx);         // Start sending transaction
            finish_item(tx);        // Complete transaction handshake
            `uvm_info(get_type_name(), $sformatf("Generated txn: %s", tx.convert2string()), UVM_LOW)
        end

        `uvm_info(get_type_name(), "DFF sequence completed.", UVM_LOW)
    endtask

endclass

