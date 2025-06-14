function [varargout] = thouAxes(ax,varargin)
%% thouAxes.m
%   Function to generate right-hand axes, matching the left-hand axes, in thou / in from mm / m (default, converts mm into thou)
%   Run with no inputs to generate an example plot
%% Inputs : 
%   fg : Figure Object
%   ax : Axes Object
%% Optional Inputs : 
%   'LeftUnits'   =   ["mm","m"]      : Either mm or m, used for conversion into the imperial units
%   'RightUnits'  =   ["in","thou"]   : Either in or thou, used for conversion into imperial units
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling
p = inputParser() ; 
addParameter(p,"LeftUnits","mm") ; acceptableUnitsLeft = ["mm","m","bar","mum","in"] ; 
addParameter(p,"RightUnits","thou") ; acceptableUnitsRight = ["in","thou","psi","mm"] ; 
addParameter(p,"AutoDebug",false) ; 
parse(p,varargin{:}) ; 
unitsLeft = p.Results.LeftUnits ; assert(max(string(unitsLeft)==acceptableUnitsLeft),"Acceptable Units Left: "+acceptableUnitsLeft) ; 
unitsRight = p.Results.RightUnits ; assert(max(string(unitsRight)==acceptableUnitsRight),"Acceptable Units Right: "+acceptableUnitsRight) ; 

% Units
switch unitsLeft
    case "mum" , factor = 1e-3 ; 
    case "mm" , factor = 1 ; 
    case "m" , factor = 1000 ; 
    case "in" , factor = 25.4 ; 
    case "bar" , factor = 1 ; 
    case "mbar" , factor = 10^-3 ; 
    case "Pa" , factor = 10^-5 ; 
end
switch unitsRight
    case "mm" , factor = factor/1 ; rightHandle = "mm" ; 
    case "in" , factor = factor/25.4 ; rightHandle = "Inches" ; 
    case "thou" , factor = factor/25.4*1000 ; rightHandle = "Thou" ; 
    case "psi" , factor = factor*14.5 ; rightHandle = "PSI" ; 
end

%% Zero-Input Handling
if nargin == 0
    x = linspace(0, 10, 100) ; 
    y = sin(x) * 0.6 ; 
    
    % Create the initial plot
    if ~exist('figGen','file') , [fg,ax] = figGen ; 
    else , figure ; ax = axes ; end
    plot(ax,x,y) ; 
    xlabel(ax,"Time (s)") ; 
    ylabel(ax,"Displacement (mm)");
    ax.YColor = 'k';
end

%% Create and Adjust Right Axes
if ax.Parent.Type == "tiledlayout"
    warning('off','MATLAB:handle_graphics:Layout:NoPositionSetInTiledChartLayout') ; 
    axRight = axes('Position',ax.Position,'XAxisLocation','bottom','YAxisLocation','right','Color','none','Parent',ax.Parent.Parent) ; 
else
    axRight = axes('Position',ax.Position,'XAxisLocation','bottom','YAxisLocation','right','Color','none','Parent',ax.Parent) ; 
end
axRight.XColor = 'none' ; 
axRight.YColor = ax.YColor ; 

axRight.YLim = ax.YLim*factor ; 
axRight.YLabel.String = rightHandle ; 

addlistener(ax,'MarkedClean',@(~,~) set(axRight,'YLim',ax.YLim*factor)) ; 

disableDefaultInteractivity(axRight) ; 
axRight.HitTest = 'off' ; 
axRight.PickableParts = 'none' ; 

set(gcf,'CurrentAxes',ax) ; 

if nargout > 0
    varargout{1} = axRight ; 
    varargout{2} = ax ; 
end

end