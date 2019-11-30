ghc sample_hold.hs
./sample_hold
c99 driver.c sampleIT.c monitor.c -o driver
rm sampleIT_sfun.mexmaci64
./driver