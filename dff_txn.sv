`include "uvm_macros.svh"
import uvm_pkg::*;

class dff_txn extends uvm_sequence_item;

    rand bit d;
    bit q;

    `uvm_object_utils(dff_txn)

    function new(string name="dff_txn");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("D=%0b Q=%0b", d, q);
    endfunction

endclass


