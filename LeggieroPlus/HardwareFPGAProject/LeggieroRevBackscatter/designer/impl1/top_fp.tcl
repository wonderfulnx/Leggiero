new_project \
    -name {top} \
    -location {C:\Users\NaXin\Documents\THU\LiberoSoC\LeggieroRevTest\designer\impl1\top_fp} \
    -mode {single}
set_programming_file -file {C:\Users\NaXin\Documents\THU\LiberoSoC\LeggieroRevTest\designer\impl1\top.pdb}
set_programming_action -action {PROGRAM}
run_selected_actions
save_project
close_project
