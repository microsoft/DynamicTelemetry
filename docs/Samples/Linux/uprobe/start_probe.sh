#!/bin/bash


# sudo cat /sys/kernel/tracing/uprobe_events

# WATCH : to watch streaming live
# sudo cat /sys/kernel/debug/tracing/trace_pipe

# Ways to get offset
#  a) objdump -T <binary> | grep function
#  b) gdb <binary>  then use 'b' (breakpoint)

# echo 'r:uprobes/bashReadline /usr/bin/bash:0x0000000000025730 cmd=+0($retval):string' >> /sys/kernel/tracing/uprobe_events
# cat /sys/kernel/debug/tracing/events/enable

echo "ARG : $1"


echo "1. Disabling uProbes"
echo 0 > /sys/kernel/debug/tracing/events/enable
echo > /sys/kernel/tracing/uprobe_events

read -p "<press any key to continue, or ctrl-c to exit>"


echo "2. Enable our entry probe"
var="p:LOOKOUT_enter /home/chgray/Source/TelAnalytics/BigRed/PoC_DynamicTelemetry/docs/web/docs/Samples/Linux/uprobe/bld/app:$1"
echo $var > /sys/kernel/tracing/uprobe_events

echo "3. Enable our return probe"
var="r:LOOKOUT_ret /home/chgray/Source/TelAnalytics/BigRed/PoC_DynamicTelemetry/docs/web/docs/Samples/Linux/uprobe/bld/app:$1"
echo $var >> /sys/kernel/tracing/uprobe_events

echo "4. Verifying"
cat /sys/kernel/tracing/uprobe_events

echo "5. Enabling Probes"
echo 1 > /sys/kernel/debug/tracing/events/enable

sudo cat /sys/kernel/debug/tracing/trace_pipe | grep LOOKOUT

# echo > /sys/kernel/tracing/uprobe_events
