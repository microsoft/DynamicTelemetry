#!/usr/bin/gnuplot -persist
#set terminal pngcairo  transparent enhanced font "arial,10" fontscale 1.0 size 1024, 768
#set output '../docs/orig_media/OpenTelemetry.RiskSpider.png'
reset session
set terminal pngcairo enhanced font "Times,16"

#
# Help : http://gnuplot.info/demo/spiderplot.html
#
#
set grid nopolar
set spiderplot
set style spiderplot  linewidth 1.000 dashtype solid pointtype 6 pointsize 2.000
set style spiderplot fillstyle transparent solid 0.20 border
set paxis 1 tics axis in scale 1,1 nomirror norotate  autojustify

set for[i=1:5] paxis i range [0 : 3]
set for[i=1:5] paxis i tics 0,1,3 axis in scale 1,10 nomirror norotate autojustify

set paxis 1 label "Privacy" font ",16"
set paxis 2 label "Security" font ",16" offset 2,0
set paxis 3 label "Reliability" font ",16"
set paxis 4 label "Costs" font ",16"
set paxis 5 label "Performance" font ",16" offset 2,0

set grid spider lt black lc "grey" lw 0.5 back

NO_ANIMATION = 1
array Array1[5] = [1,2,3,2,1]
array Array2[5] = [3,3,3,1,2]


#Privacy,Security,Reliability,Costs,Performance
array OpenTelemetry[5] = [1,1,1,1,1]
array DTrace[5]        = [3,3,2,2,2]
array eBPF[5]          = [3,3,3,2,2]
array ptrace[5]        = [3,3,2,2,3]
array user_events[5]   = [1,1,1,1,1]
array uprobes[5]       = [3,3,2,2,2]
array etw[5]           = [1,1,2,1,1]

set output "../docs/orig_media/Risk.OpenTelemetry.png"
set title "Probe Risk Chart : OpenTelemetry" offset 0,2 font ",20"
plot for [i=1:|OpenTelemetry|] OpenTelemetry using (OpenTelemetry[i]) lc 3 lw 3

set output "../docs/orig_media/Risk.DTrace.png"
set title "Probe Risk Chart : DTrace" offset 0,2 font ",20"
plot for [i=1:|DTrace|] DTrace using (DTrace[i]) lc 3 lw 3

set output "../docs/orig_media/Risk.eBPF.png"
set title "Probe Risk Chart : eBPF" offset 0,2 font ",20"
plot for [i=1:|eBPF|] eBPF using (eBPF[i]) lc 3 lw 3

set output "../docs/orig_media/Risk.ptrace.png"
set title "Probe Risk Chart : ptrace" offset 0,2 font ",20"
plot for [i=1:|ptrace|] ptrace using (ptrace[i]) lc 3 lw 3

set output "../docs/orig_media/Risk.user_events.png"
set title "Probe Risk Chart : user_events" offset 0,2 font ",20"
plot for [i=1:|user_events|] user_events using (user_events[i]) lc 3 lw 3

set output "../docs/orig_media/Risk.uprobes.png"
set title "Probe Risk Chart : uprobes" offset 0,2 font ",20"
plot for [i=1:|uprobes|] uprobes using (uprobes[i]) lc 3 lw 3

set output "../docs/orig_media/Risk.ETW.png"
set title "Probe Risk Chart : ETW" offset 0,2 font ",20"
plot for [i=1:|etw|] etw using (etw[i]) lc 3 lw 3