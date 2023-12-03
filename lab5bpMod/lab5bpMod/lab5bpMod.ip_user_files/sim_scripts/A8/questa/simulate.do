onbreak {quit -f}
onerror {quit -f}

vsim -lib xil_defaultlib A8_opt

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {A8.udo}

run -all

quit -force
