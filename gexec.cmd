# project name
name TransiXOR
# execution graph
job 3 -d "1"  -post { extract_vars "$wdir" n3_des.out 3; waiting "$wdir" 3 des }  -o n3_des "sdevice pp3_des.cmd"
job 1   -post { extract_vars "$wdir" n1_dvs.out 1; waiting "$wdir" 1 dvs }  -o n1_dvs "sde -e -l n1_dvs.cmd"
check sde_dvs.cmd 1488170215
check sdevice_des.cmd 1488746938
check sdevice.par 1488151932
check svisual_vis.tcl 1446510809
check global_tooldb 1445040373
check gtree.dat 1488169316
check gtooldb.tcl 1446510809
check InGaAs.par 1488171052
# included files
file sdevice.par included InGaAs.par
