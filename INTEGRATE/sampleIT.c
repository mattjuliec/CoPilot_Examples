// From https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html
// to create monitor c code from haskell > ghc 
// > ghc monitor.hs
//  > ./monitor
//  > c99 doubleIT.c monitor.c -o doubleIT

//include the copilot monitor header file
#include <stdint.h>
#include <stdbool.h>
#include "monitor.h"

// initialize the global variable accessed by the monitor
double value;

// define the functions that are triggered if the monitor  
// sees a value that triggers the specification

void heaton(double too_high_arg0)
{
     value = too_high_arg0;
}

// Consider the function "sampleIT" as a function that takes in a value and does something to it. 
// For the sake of this argument, let's say the function just takes in a stream value and then
// outputs whatever is provided. 
double sampleIT(double u)
{
// monitor pre-conditions
     value = u;
     step();
     // output the value
     return(value);
}

