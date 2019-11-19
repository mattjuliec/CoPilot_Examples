// From https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html
// to create monitor c code from haskell > ghc 
// > ghc monitor.hs
//  > ./monitor
//  > c99 doubleIT.c monitor.c -o doubleIT

//include the copilot monitor header file
#include "monitor.h"

// initialize the global variable accessed by the monitor
double value = 0.0;

// define the functions that are triggered if the monitor sees a value that violates the 
// specification
void too_low(double too_low_arg0)
{
     value = 0.0;
}
void too_high(double too_high_arg0)
{
     value = 200.0;
}

// read in the value from the simulation, double it, and then check to see if the 
// monitor is triggered.
double doubleIT(double u)
{
     value = u*2;
     step();
     return(value);
}

