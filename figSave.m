function figSave(handle,fName)
%% figSave.m 
% Save figure as both .png and .fig with correct options 
%% Inputs: 
%  handle    : Figure handle reference eg. fg3 
%  fName     : File name to save under 
%% Outputs: (Saved in same directory)
%  fName.png : 900 dpi .png 
%  fName.fig : Compact .fig 

exportgraphics(handle,fName+".png",'Resolution',400) ; 
savefig(handle,fName+".fig",'compact') ; 
exportgraphics(handle,fName+".pdf",'Resolution',400) ; 
