/*--------------------------------------------------------------------------------
-- Copyright © 2011 National Institute of Aerospace / Galois, Inc.
--------------------------------------------------------------------------------

| Example implementing an engine cooling control system.
> ghc Engine.hs
> ./Engine.hs
> c99 driver.c engine.c -o driver
> ./driver
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "monitor.h"
#include "sampleIT.h"

double sampleIT(double u);

int main (int argc, char const *argv[])
{
    int i;
    value = 0.0;
    printf("|Iteration|    |    Value   |\n");
    for (i = 0; i < 10; i++)
        {
            value = sampleIT(value);
            printf("|    %d    |    |  %f  |\n",i,value);
            value = value+0.1;
        }
        return 0;
}
