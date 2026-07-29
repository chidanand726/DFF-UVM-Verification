#==========================================
# run.do
#==========================================

transcript on

# Delete previous library
if {[file exists work]} {
    vdel -lib work -all
}

# Create work library
vlib work
vmap work work

#------------------------------------------
# Compile with Code Coverage
#------------------------------------------

vlog -sv -cover bcesft dff_design.sv
vlog -sv -cover bcesft dff_if.sv
vlog -sv -cover bcesft dff_pkg.sv
vlog -sv -cover bcesft dff_top.sv
#------------------------------------------
# Start Simulation
#------------------------------------------

vsim -coverage work.dff_top

#------------------------------------------
# Waveform
#------------------------------------------

view wave
view structure
view signals

add wave -r /*

#------------------------------------------
# Log all signals
#------------------------------------------

log -r /*

#------------------------------------------
# Run Simulation
#------------------------------------------

run -all

#------------------------------------------
# Save Coverage
#------------------------------------------

coverage save dff.ucdb

#------------------------------------------
# Coverage Report
#------------------------------------------

coverage report -details

#------------------------------------------
# Zoom Wave
#------------------------------------------

wave zoom full