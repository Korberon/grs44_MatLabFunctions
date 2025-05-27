function figSave(handle,fName,varargin)
%% figSave.m 
%   Save figure as both .png and .fig with correct options 
%% Inputs: 
%    handle    : Figure handle reference eg. fg3 
%    fName     : File name to save under 
%% Outputs: (Saved in same directory)
%    fName.png : 200 dpi  .png
%    fName.pdf : 200 dpi  .pdf
%    fName.eps :          .eps
%    fName.fig : Compact  .fig
%
%% Optional Inputs  :
% 'png'=true/false  : Save as .png
% 'pdf'=true/false  : Save as .pdf
% 'eps'=true/false  : Save as .eps
% 'fig'=true/false  : Save as .fig
% 'pngRes'=N        : Resolution of .png
% 'pdfRes'=N        : Resolution of .pdf
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling:
p = inputParser() ;
addParameter(p,"png",true) ; 
addParameter(p,"pngRes",200) ; 
addParameter(p,"pdf",false) ; 
addParameter(p,"pdfRes",200) ; 
addParameter(p,"eps",false) ; 
addParameter(p,"fig",true) ; 
addParameter(p,"SaveDate",false) ; 

parse(p,varargin{:}) ; 
pngBool = p.Results.png ;
pngRes = p.Results.pngRes ; 
pdfBool = p.Results.pdf ;
pdfRes = p.Results.pdfRes ; 
epsBool = p.Results.eps ;
figBool = p.Results.fig ;
getDateBool = p.Results.SaveDate ; 

%% Save DateFolder
if getDateBool , mkdir(getDate) ; fName = getDate+"/"+fName ; end

%% Save:
if pngBool , exportgraphics(handle,fName+".png",'Resolution',pngRes) ; end
if pdfBool , exportgraphics(handle,fName+".pdf",'Resolution',pdfRes) ; end
if epsBool , exportgraphics(handle,fName+".eps") ; end 
if figBool , savefig(handle,fName+".fig",'compact') ; end

end