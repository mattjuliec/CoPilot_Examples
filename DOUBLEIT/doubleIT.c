// From https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html
// to create monitor c code from haskell > ghc 
// > ghc monitor.hs
//  > ./monitor
//  > c99 doubleIT.c monitor.c -o doubleIT

#include "monitor.h"

double value = 0.0;

void too_low(double too_low_arg0)
{
     value = 0.0;
}
void too_high(double too_high_arg0)
{
     value = 200.0;
}

double doubleIT(double u)
{
     value = u*2;
     step();
     return(value);
}

