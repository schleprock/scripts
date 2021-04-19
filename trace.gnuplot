set terminal x11 size 1850,1000
set datafile separator ','
set terminal x11 linewidth 2
theFile=ARG1
set title theFile
plot for [col=2:6] theFile using 1:col with lines title columnhead
pause -1
