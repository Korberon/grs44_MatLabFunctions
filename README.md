A load of files with mixed functionality:
- Figure stuff: annoTable.m , cmapGen.m , fig3D.m , figGen.m , makeLatex.m , tiledGen.m
- Central differencing: centralDifference1.m , centralDifference2.m
- Fourier Transform: dFT.m
- Mass-Spring-Damper: quickMSD.m

It's highly recommended to do the following:
1. Create a file named "startup.m" under '/Documents/MATLAB'
2. Create a folder somewhere, eg. on the dreaded OneDrive, to save the MATLAB functions that you'll use
3. In "startup.m", copy and paste the folder directory into an addpath() function, ie. addpath("C:\Users\Korberon\OneDrive\MatLab Functions") ;
By then writing any function in the folder designated, it can be called from anywhere! (requires a MATLAB restart to run for first time)

%% annotable.m 
% Function to create annotation tables (similar to a legend) 
%% Inputs  : 
% fg       : Figure object 
% ax       : Axes object 
% N        : Number of rows 
% M        : Number of columns 
% Loc      : Location of annotation [ horizontal fraction , vertical fraction ] of axes 
% varargin : [width,height] of cell (relative to horizontal axis dimension) 
%% Outputs : 
% an       : Annotation object 
    % an(i,j).a || Colour box of row i , column j 
    % an(i,j).b || Text box of row i , column j 
%% Example Code : 
% [fg,ax] = figGen ; an = annoTable(fg,ax,2,1,[1,1]) ; % Generic annotation table in the top right with default colours, in a 2x1 grid. Use an() as in 'Outputs : ' above
% [fg,ax] = figGen ; an = annoTable(fg,ax,2,1,[1,1],[0.12,0.08]) ; % Generic annotation table, which is 0.12 wide, 0.08 tall
% [fg,ax] = figGen ; an = annoTable(fg,ax,2,1,[1,1],[0.12,0.08],0.06) ; % Generic annotation table, where an().a is 0.06x0.08, an().b is 0.12x0.08

%% centralDifference1.m
% Needs a proper readme, but for now, give it a delta and data and which index of the vector to do the central differencing on, and it does a first order central differencing

%% centralDifference2.m
% Needs a proper readme, but for now, give it a delta and data and which index of the vector to do the central differencing on, and it does a second order central differencing

%% cmapGen.m
% Colour map generator for my colour palette

%% dFT.m 
% Simple Direct Fourier Transform Code to target specific frequencies around a given point 
%% Example Code: 
% tTest = 0 : 0.001 : 4 ; yTest = 2*sin(tTest*2*pi*3+pi/3) ; fg = figure ; fg.Position = [1920/2-1200/2,1080/2-600/2,1200,600] ; ax = axes ; hold all ; grid on ; grid('minor') ; ax.TickLabelInterpreter = 'latex' ; ax.FontSize = 12 ; xlabel("Time (s)",'Interpreter','Latex','FontSize',16) ; ylabel("Response (u)",'Interpreter','latex','FontSize',16) ; plot(tTest,yTest,'k-','LineWidth',2,'DisplayName','dFT Output') ; [YTest] = dFT(tTest,yTest,3,'HzRange',0.1,'HzNo',2,'Weighted') ; plot(tTest,abs(YTest)*cos(tTest*2*pi*3 + angle(YTest)),'r--','LineWidth',2,'DisplayName','dFT Output') ; legend('Interpreter','latex','Location','southoutside','orientation','Horizontal','FontSize',12) ; 
%% Inputs: 
%  t        : Time Data                                     (s) 
%  y        : Input Data                                    (u) 
%  Hz       : Target Frequency                              (Hz) 
%% Optional Inputs: 
% HzRange   : Specific range of frequencies to analyse      (Hz-Hz) 
% HzNo      : Number of frequencies to analyse either side  (Int) 
% Weighted  : Sets weighting regime to Hann                 (None) 
%% Outputs: 
%  Y        : Fourier Transform of Y                        (U) 
%             Positive phase from cosine 

%% fig3D.m
% Generate a generic 3D figure to create consistent plots 
%% Optional Inputs:
%  'lg'       : Creates and displays the legend. This changes the way the axes fits in the figure
%  'FontSize' : Changes the relative font sizes for the figure (default 12)
%   - fontSize
%  'Title'    : Creates title and rearranges the axes
%  'Subtitle' : Creates subtitle and rearranges the axes
%  'ColorBar' : Creates a colorbar (default using hsv).
%   - N       : Number of colours in the colorbar
%  'cbType'   : Changes the default colorbar format
%   - cbType  : Equation to change the colorbar format to, eg. '1-cool'
%  'cbRev'    : Reverses the colorbar order
%% Outputs + Order:
%  'fg'       : Figure object
%  'ax'       : Axes object
%  'lg'       : Legend object
%  'cBar'     : Colorbar Object
%% Example Code: 
% To use fig3D(), here are some example codes: 
% [fg,ax] = fig3D() ; % Generic Set of Axes on a Figure 
% [fg,ax,lg] = fig3D('lg') ; % Generic + Empty Legend (use 'DisplayName' in plots / scatters) 
% [fg,ax] = fig3D('Title') ; % Generic + Title 
% [fg,ax,lg] = fig3D('Title','lg') ; % Generic + Empty Legend + Title 
% [fg,ax,cb] = fig3D('ColorBar',6) ; % Generic + Colourbar 
% [fg,ax,cb] = fig3D('ColorBar',6,'cbRev','cbType','1-cool') ; % Generic + More complicated colourbar, which has colours equal to 1-cool, in reverse order 
% [fg,ax,lg,cb] = fig3D('ColorBar',6,'lg') ; % Generic + Colourbar + Legend 

%% figGen.m
% Generate a generic figure to create consistent plots
%% Optional Inputs:
%  'lg'       : Creates and displays the legend. This changes the way the axes fits in the figure
%  'FontSize' : Changes the relative font sizes for the figure (default 12)
%   - fontSize
%  'Title'    : Creates title and rearranges the axes
%  'Subtitle' : Creates subtitle and rearranges the axes
%  'ColorBar' : Creates a colorbar (default using hsv).
%   - N       : Number of colours in the colorbar
%  'cbType'   : Changes the default colorbar format
%   - cbType  : Equation to change the colorbar format to, eg. '1-cool'
%  'cbRev'    : Reverses the colorbar order
%% Outputs + Order:
%  'fg'       : Figure object
%  'ax'       : Axes object
%  'lg'       : Legend object
%  'cBar'     : Colorbar Object

%% Example Code: 
% To use figGen(), here are some example codes: 
% [fg,ax] = figGen() ; % Generic Set of Axes on a Figure 
% [fg,ax,lg] = figGen('lg') ; % Generic + Empty Legend (use 'DisplayName' in plots / scatters) 
% [fg,ax] = figGen('Title') ; % Generic + Title 
% [fg,ax,lg] = figGen('Title','lg') ; % Generic + Empty Legend + Title 
% [fg,ax,cb] = figGen('ColorBar',6) ; % Generic + Colourbar 
% [fg,ax,cb] = figGen('ColorBar',6,'cbRev','cbType','1-cool') ; % Generic + More complicated colourbar, which has colours equal to 1-cool, in reverse order 
% [fg,ax,lg,cb] = figGen('ColorBar',6,'lg') ; % Generic + Colourbar + Legend 

%% figSave.m 
% Save figure as both .png and .fig with correct options 
%% Inputs: 
%  handle    : Figure handle reference eg. fg3 
%  fName     : File name to save under 
%% Outputs: (Saved in same directory)
%  fName.png : 400 dpi .png 
%  fName.fig : Compact .fig 
%  fName.pdf : 400 dpi .pdf

%% makeLatex.m
% Function to correct any set of axes to the appropriate LaTeX format and outlines
%% Inputs: 
% ax    : Set of axes to correct
%% Outputs: 
% ax    : Corrected set of axes

%% quickMSD.m
% Needs a proper readme
% Generates a mass-spring-damper response for a given system or generic if left empty

%% tiledGen.m
% Create and format a generic tiled layout easily
%% Inputs           : 
% N                 : Number of rows
% M                 : Number of columns
% dicing            : How the rows and columns are divided, in order of nexttile() ; 
%% Optional Inputs  : 
% 'Title'           : Adds a title to the whole figure
% 'Subtitle'        : Adds a subtitle to the whole figure
% 'Eachtitle'       : Adds a title to each set of axes
% 'Eachsubtitle'    : Adds a subtitle to each set of axes
% 'fontSize' + sz   : Determines fontSize
% 'lg'              : Adds a legend at the south centre, targetting the final set of axes
% 'lgTile' + lgi    : Determines which tile the legend will target 
%% Outputs          :
% fg                : Figure object
% tl                : Tiled layout object
% ax                : Axes object
%   ax(n,m)         : Specific axis, row n, column m
%   ax(i)           : Specific axis, in order of nexttile() ; 
%% Example Code : 
% [fg,tl,ax] = tiledGen(3,2) ; % Generic tiled plot in a 3x2, with default 1x1 dicing
% [fg,tl,ax] = tiledGen(3,3,[3,2;2,1;1,1]) ; % Specific way of dicing a 3x3 plot into a 3x2, 2x1 and a 1x1 in that order
% [fg,tl,ax] = tiledGen(3,3,[3,2;2,1]) ; % Specific way of dicing a 3x3 plot into a 3x2, 2x1 and an empty 1x1 in that order
% [fg,tl,ax] = tiledGen(2,1) ; plot(ax(1,1),0:10,10-(0:10).^2) ; plot(ax(2,1),0:0.01:2*pi,sin(0:0.01:2*pi)) ; % Showing how to access specific axes using row / column 
% [fg,tl,ax] = tiledGen(3,2) ; for i = 1 : 6 , plot(ax(i),0:0.01:2*pi,sin((0:0.01:2*pi)*i)) ; end ; % Showing how to use the tiled indices in a plot() ; function 
% [fg,tl,ax] = tiledGen(3,3,[3,2;2,1;1,1]) ; for i = 1 : 3 , plot(ax(i),0:0.01:2*pi,sin((0:0.01:2*pi)*i)) ; end ; % Showing how to use the tiled indices in a plot() ; function, with non-default dicing 
% [fg,tl,ax] = tiledGen(3,3,[3,2;2,1;1,1]) ; for i = 1 : 3 , plot(ax(i),0:0.01:2*pi,sin((0:0.01:2*pi)*i)) ; end ; % Showing how to use the tiled indices in a plot() ; function, with non-default dicing 
% [fg,tl,ax,lg] = tiledGen(2,2,[],'lg') ; colList = summer(3) ; for i = 1 : 3 , plot(ax(i),0:0.01:2*pi,sin((0:0.01:2*pi)*i),'LineWidth',2) ; plot(ax(end),0:0.01:2*pi,sin((0:0.01:2*pi)*i),'LineWidth',2,'Color',colList(i,:),'DisplayName','Plot \#'+string(i)) ; end % Showing how the legend targets the final set of axes, and how to set it up
% [fg,tl,ax,lg,cb] = tiledGen(2,2,[],'lg','ColorBar',3,'cbType','summer') ; colList = summer(3) ; for i = 1 : 3 , plot(ax(i),0:0.01:2*pi,sin((0:0.01:2*pi)*i),'LineWidth',2) ; plot(ax(end),0:0.01:2*pi,sin((0:0.01:2*pi)*i),'LineWidth',2,'Color',colList(i,:),'DisplayName','Plot \#'+string(i)) ; end % Colourbar example
