  # Set project directory and create it
  set workdir {/home/zwk/Project/FPGA_Proj/demo1}
  set workdir [file normalize $workdir]
  cd $workdir
  set prjname wave_gen_project
  file mkdir ./$prjname
  #set part xc7a200tsbg484-1
  set part xczu3eg-sfvc784-2-i
  create_project $prjname ./$prjname -part $part
  # Add design source to this project
  add_files -fileset sources_1 -norecurse -scan_for_includes -quiet ./src
  update_compile_order -fileset sources_1
  add_files -fileset sources_1 ./ip/char_fifo/char_fifo.xci
  add_files ./ip/clk_core/clk_core.xci
  update_compile_order -fileset sources_1
  add_files -fileset constrs_1 -quiet ./xdc
  add_files -fileset sim_1 -quiet ./sim
  update_compile_order -fileset sim_1
  puts "Create project correctly!"
  # Synthesis, implementation and bitgen
  launch_runs synth_1
  wait_on_run synth_1
  launch_runs impl_1 -to_step write_bitstream
  wait_on_run impl_1
  open_run impl_1
  start_gui