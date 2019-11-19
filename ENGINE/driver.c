#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "engine.h"

uint8_t tmp_probe_1;
uint8_t tmp_probe_0;
uint8_t tmp_probe_2;
bool cooler;

void shutoff(bool shutoff_arg0) {
    printf("Shutoff has been evoked!\n");
}

void over_temp_rise()
{
    printf("The trigger has been evoked!\n");
}

int main (int argc, char const *argv[])
{
    int i;
    tmp_probe_0 = 1;
    tmp_probe_1 = 1;
    tmp_probe_2 = 1;
    cooler = false; // cooler is not engaged at the beginning

    for (i = 0; i < 100; i++)
        {
            printf("iteration: %d\n", i);
            tmp_probe_0 = tmp_probe_0+5;
            tmp_probe_1 = tmp_probe_1+5;
            tmp_probe_2 = tmp_probe_2+5;
	    cooler = !cooler;
            step();
        }
        return 0;
}
