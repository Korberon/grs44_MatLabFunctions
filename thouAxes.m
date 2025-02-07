function [varargout] = thouAxes(fg,ax,varargin)

%% Optional Inputs
p = inputParser() ; 
addParameter(p,"LeftUnits","mm") ; acceptableUnitsLeft = ["mm","m"] ; 
addParameter(p,"RightUnits","thou") ; acceptableUnitsRight = ["in","thou"] ; 
parse(p,varargin{:}) ; 
unitsLeft = p.Results.LeftUnits ; assert(max(unitsLeft==acceptableUnitsLeft),"Acceptable Units Left: "+acceptableUnitsLeft) ; 
unitsRight = p.Results.RightUnits ; assert(max(unitsRight==acceptableUnitsRight),"Acceptable Units Right: "+acceptableUnitsRight) ; 

%% Units

switch unitsLeft
    case "mm" , factor = 1 ; 
    case "m" , factor = 1000 ; 
end
switch unitsRight
    case "in" , factor = factor/25.4 ; rightHandle = "Inches" ; 
    case "thou" , factor = factor/25.4*1000 ; rightHandle = "Thou" ; 
end

%% Zero-Input Handling
if nargin == 0
    x = linspace(0, 10, 100);
    y = sin(x) * 0.6;
    
    % Create the initial plot
    if exist('figGen','file') , [fg,ax] = figGen ; 
    else , fg = figure ; ax = axes ; end
    plot(ax,x,y);
    xlabel(ax,"Time (s)") ; 
    ylabel(ax,"Displacement (mm)");
    ax.YColor = 'k';
end



%% Create and Adjust Right Axes
axRight = axes('Position',ax.Position,'XAxisLocation','bottom','YAxisLocation','right','Color','none') ; 
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
    varargout{1} = fg ; 
    varargout{2} = ax ; 
    varargout{3} = axRight ; 
end

end