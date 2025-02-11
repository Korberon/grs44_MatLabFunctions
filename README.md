A load of files with mixed functionality:
- Figure Generation: argandGen.m , figGen.m , figPlace.m , figSave.m , makeLatex.m , standardRes.m , thouAxes.m , tiledGen.m
- Plotting: annoTable.m , annoTableRaw.m , plotAbsolute.m
- Central & Forward differencing: centralDifference1.m , centralDifference2.m , fwdDifference1.m
- Fourier Transform: dFT.m , easyFFT.m
- Simulation: quickMSD.m , quickSinusoid.m
- Other: clickPlot.m , getDate.m , sodoff.m , startup.m

It's highly recommended to do the following:
1. Create a file named "startup.m" under '/Documents/MATLAB'
2. Create a folder somewhere, eg. on the dreaded OneDrive, to save the MATLAB functions that you'll use
3. In "startup.m", copy and paste the folder directory into an addpath() function, ie. ``` addpath("C:\Users\Korberon\OneDrive\(_PhD\MatLab Functions") ; ``` is mine
By then saving any function in the folder designated, it can be called from anywhere! (requires a MATLAB restart to run for first time)

List of Functions & One-Sentence Description (see "help functionName" in MatLab for more):
- annoTable() - Generate an annotation table on a specified axis
- annoTableRaw() - Low-level annoTable
- argandGen() - Generate a Figure, set up for an Argand (complex) plot
- centralDifference1() - Central difference a signal (1st order)
- centralDifference2() - Central difference a signal (2nd order)
- clickPlot() - Generates the data from a figure based on your clicks
- dFT() - Generate a dFT for a specified signal
- easyFFT() - fft() but easier because I spend half my life writing out the three lines of code in here
- figGen() - Generate a figure, axes, etc., very modular, VERY USEFUL!
- figPlace() - Place a figure wherever on the specified monitors
- figSave() - Save the figure with specified / default output types
- fwdDifference1() - Forward Differencing (1st order)
- getDate() - Get the date :D (replaces the now redundant datenow function)
- makeLatex() - Makes an axes object LaTeX formatting, like figGen
- plotAbsolute() - Plot on the figure in absolute units
- quickMSD() - Generates a Mass-Spring-Damper response
- quickSinusoid() - Generates a Sinusoid
- sodoff() - Restarts MatLab without restarting MatLab
- standardRes() - Standard resolution sizes for different monitors
- startup() - Example startup file
- thouAxes() - Generates a Right-Hand axes in Imperial
- tiledGen() - Generate a tiled figure, axes, etc., very modular, VERY USEFUL!
