# Created by Microsemi Libero Software 11.9.6.7
# Tue Oct 15 04:17:03 2024

# (OPEN DESIGN)

open_design "top.adb"

# set default back-annotation base-name
set_defvar "BA_NAME" "top_ba"
set_defvar "IDE_DESIGNERVIEW_NAME" {Impl1}
set_defvar "IDE_DESIGNERVIEW_COUNT" "1"
set_defvar "IDE_DESIGNERVIEW_REV0" {Impl1}
set_defvar "IDE_DESIGNERVIEW_REVNUM0" "1"
set_defvar "IDE_DESIGNERVIEW_ROOTDIR" {C:\Users\NaXin\Documents\THU\LiberoSoC\LeggieroRevBackscatter\designer}
set_defvar "IDE_DESIGNERVIEW_LASTREV" "1"

backannotate -format "SDF" -language "VERILOG" -netlist

save_design
