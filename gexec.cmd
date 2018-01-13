# project name
name XNOR
# execution graph
job 3 -d "1"  -post { extract_vars "$wdir" n3_des.out 3; waiting "$wdir" 3 des }  -o n3_des "sdevice pp3_des.cmd"
job 1   -post { extract_vars "$wdir" n1_dvs.out 1; waiting "$wdir" 1 dvs }  -o n1_dvs "sde -e -l n1_dvs.cmd"
check sde_dvs.cmd 1515875897
check sdevice_des.cmd 1515885733
check sdevice.par 1515875897
check svisual_vis.tcl 1515875897
check global_tooldb 1445040373
check gtree.dat 1515875897
check gtooldb.tcl 1515875897
check InGaAs.par 1515879556
# included files
file sdevice.par included InGaAs.par
