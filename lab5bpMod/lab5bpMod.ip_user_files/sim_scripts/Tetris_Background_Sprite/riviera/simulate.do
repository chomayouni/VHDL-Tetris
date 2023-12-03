transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+Tetris_Background_Sprite  -L xpm -L blk_mem_gen_v8_4_6 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.Tetris_Background_Sprite xil_defaultlib.glbl

do {Tetris_Background_Sprite.udo}

run 1000ns

endsim

quit -force
