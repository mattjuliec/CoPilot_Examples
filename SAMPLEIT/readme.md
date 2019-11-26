# Using Copilot in a Matlab Simulation 
## sampleIt.c example to demonstrate the ability to sample a discrete system

Each example is intended to be self contained. 
This example assumes you have the Haskell Glasgow Compiler and Matlab with the Simulink Toolbox installed on a local machine
To install the CoPilot type in a terminal:
```bash
> cabal install copilot
```
To create a demo function in Matlab that reads in a value and doubles it. Follow the instructions in
https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html
Refer to the DOUBLEIT example for configuration details
[DOUBLEIT]/readme.md/  


Now compile the Copilot Monitor and execute it to generate the c source files:

```bash
> ghc monitor.hs
> ./monitor
```
This will generate two files; monitor.c and monitor.h

To compile the monitor as a C99 object file type:

```bash
> c99 -c monitor.c
```



