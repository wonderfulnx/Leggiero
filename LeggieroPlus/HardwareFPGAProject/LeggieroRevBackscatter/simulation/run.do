quietly set ACTELLIBNAME IGLOO
quietly set PROJECT_DIR "C:/Users/NaXin/Documents/THU/LiberoSoC/LeggieroRevBackscatter"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap igloo "C:/Program Files (x86)/Microsemi/Libero_SoC_v11.9/Designer/lib/modelsim/precompiled/vlog/igloo"

vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/ASWControl.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/smartgen/CLKGEN/CLKGEN.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/Key.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/PKT_DECT.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/RFSWControl.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/hdl/Modulator.v"
vlog "+incdir+${PROJECT_DIR}/hdl" -vlog01compat -work presynth "${PROJECT_DIR}/component/work/top/top.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/stimulus" -vlog01compat -work presynth "${PROJECT_DIR}/stimulus/top_tb.v"

vsim -L igloo -L presynth  -t 1ps presynth.top_tb
add wave /top_tb/*
run 1000ns
