# Using Copilot in a Matlab Simulation 
## DoubleIt.c example with a upper and lower boundary provided by a Copilot monitor
Source taken from the Mathworks cite: 
https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html

Each example is intended to be self contained. 
This example assumes you have the Haskell Glasgow Compiler and Matlab with the Simulink Toolbox installed on a local machine
To install the CoPilot type in a terminal:
```bash
> cabal install copilot
```
To create a demo function in Matlab that reads in a value and doubles it. Follow the instructions in
https://www.mathworks.com/help/simulink/ug/incorporate-c-code-using-a-matlab-function-block.html

Change the model to generate a continuous stream rather than just a value as shown here:

![](images/SIMULINK_MODEL.png =400x300)
![](images/MATLAB_SIMULINK_BLOCK_CODE.png =500x250)


Set the step function to run with the following parameters

![](images/STEP_FUNC_PARAMS.png =500x500)

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

Now configure the parameters in Simulink (under simulation / model configuration parameters) as shown:

![](images/SIMULATION_PARAMS.png =400x300)
![](images/SIMULATION_PARAMS02.png =400x300)

Once complete, you should see the below graph. Notice that any value below 0.0 and above 200.0 is truncated based on the triggers established in CoPilot

![](images/DOUBLEIT_GRAPH.png =500x500)




