#----------------------------------------------------------------------#
lib::SetInfoDef 1
#----------------------------------------------------------------------#
set N @node@
set i @node:index@

#- Automatic alternating color assignment tied to node index
#----------------------------------------------------------------------#
set COLORS  [list green blue red orange magenta violet brown]
set color  [lindex $COLORS [expr $i%[llength $COLORS]]]

#----------------------------------------------------------------------#
#if @IdVd@ == 0
echo "Plotting Id vs Vg curve"

if {[lsearch [list_plots] Plot_IdVg] == -1} {
	create_plot -1d -name Plot_IdVg
	set_plot_prop -title "I<sub>d</sub>-V<sub>gs</sub> Characteristics" -title_font_size 20 -show_legend
	set_axis_prop -axis x -title {Gate Voltage [V]} \
		-title_font_size 16 -scale_font_size 14 -type linear 
	set_axis_prop -axis y -title {Drain Current [mA/mm]} \
		-title_font_size 16 -scale_font_size 14 -type linear	
	set_legend_prop -font_size 12 -location top_left -font_att bold	
}
select_plots Plot_IdVg

load_file IdVg_@plot@ -name PLT($N)

# Convert drain current units from A/um -> mA/mm
set Ids [get_variable_data "drain TotalCurrent" -dataset PLT($N)]
ext::LinTransList -out scaledIds -x $Ids -m 1e6
create_variable -name scaledId -dataset PLT($N) -values $scaledIds

create_curve -name Id($N) -dataset PLT($N) \
	-axisX "gate OuterVoltage" -axisY "scaledId"

set_curve_prop Id($N) -label "Id($N) (V<sub>ds</sub>=@Vd@ V)" \
	-color $color -line_style solid -line_width 3
	
echo "Extracting parameters"
set Vgs [get_variable_data "gate OuterVoltage" -dataset PLT($N)]
#- Defining current level for Vti extraction
set Io 1 ; # [mA/mm]
ext::ExtractVtgm 	 -out Vt 	-name Vtgm 	-v $Vgs -i $scaledIds
ext::ExtractVti 	 -out Vti 	-name Vti 	-v $Vgs -i $scaledIds -io $Io
ext::ExtractGm 		 -out gm 	-name gm 	-v $Vgs -i $scaledIds
ext::ExtractExtremum -out Idmax -name IdMax -x $Vgs -y $scaledIds

echo "Vt (Max gm method) is [format %.3f $Vt] V"
echo "Vti (Vg at Io= [format %.3e $Io] mA/mm) is [format %.3f $Vti] V"
echo "Max gm is [format %.3e $gm] mS/mm"
echo "Max Id is [format %.3e $Idmax] mA/mm"

#--------------------------------------------------------#
#else
echo "Plotting Family of Id vs Vd curves"

if {[lsearch [list_plots] Plot_IdVd] == -1} {
	create_plot -1d -name Plot_IdVd
	set_plot_prop -title "I<sub>d</sub>-V<sub>ds</sub> Characteristics" -title_font_size 20 -show_legend
	set_axis_prop -axis x -title {Drain Voltage [V]} \
		-title_font_size 16 -scale_font_size 14 -type linear 
	set_axis_prop -axis y -title {Drain Current [mA/mm]} \
		-title_font_size 16 -scale_font_size 14 -type linear
	set_legend_prop -font_size 12 -location top_left -font_att bold	
}
select_plots Plot_IdVd

set IDVDs [glob IdVd_*_@plot@]

set i 0
foreach IDVD $IDVDs {
	set color [lindex $COLORS [expr $i%[llength $COLORS]]]
	load_file $IDVD -name PLT($N,$i)

	# Convert drain current units from A/um -> mA/mm
	set Ids [get_variable_data "drain TotalCurrent" -dataset PLT($N,$i)]
	ext::LinTransList -out scaledIds -x $Ids -m 1e6
	create_variable -name scaledId -dataset PLT($N,$i) -values $scaledIds

	create_curve -name Id($N,$i) -dataset PLT($N,$i) \
		-axisX "drain OuterVoltage" -axisY "scaledId"
		
	set Vgs [get_variable_data "gate OuterVoltage" -dataset PLT($N,$i)]
	set Vg [lindex $Vgs 0]	
	set_curve_prop Id($N,$i) -label "Id($N,$i) (V<sub>gs</sub>=$Vg V)" \
		-color $color -line_style solid -line_width 3	
	
	incr i
}

echo "Extracting Ron"
set Vds [get_variable_data "drain OuterVoltage" -dataset PLT($N,2)]
set Ids [get_variable_data "drain TotalCurrent" -dataset PLT($N,2)]
ext::LinTransList -out scaledIds -x $Ids -m 1e6

ext::ExtractRdiff -out Ron -name out -v $Vds -i $scaledIds -vo 1.0
echo "On-state resistance is [format %.3f $Ron] kOhm-mm"
#endif
