function [fg,ax,lg,varargout] = figGen(varargin)
%% figGen.m
%   Figure Generator, with many optional inputs. Made to work with all other files in my directory! MUST have!
%% Inputs   :
%   None
%% Outputs  :
%   fg      : Figure object
%   ax      : Axes object
%   lg      : Legend object
%
%% Optional Inputs          :
%   'Title'=true/false      : Create a title object for the axes
%   'Subtitle'=true/false   : Create a subtitle object for the axes
%   'lg'=true/false         : Create a legend for the axes
%   'Place'=figPlace.m      : Places the axes in the position (see figPlace.m)
%   'fig3D'=true/false      : Generate the figure and set up the angle to be in 3D (Replaces the old fig3D.m)
%   'FontSize'=u            : General font size for the axes object (all text scales relative to this!)
%   'Square'=true/false     : The axes are square
%   'ColorBar'=u/false      : Generates a ColorBar with the specified input (either false or N)
%   'cbType'=colorMap       : Sets the colourmap of the Colorbar object (eg. "winter","summer","1-summer" etc.)
%   'cbRev'=true/false      : Reverses the cbType
%% Optional Outputs :
%   cBar            : Colorbar Object
%   dbgObject       : The debugging object (containing all relevant data)
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling
p = inputParser() ; 
% Figure
addParameter(p,'Title',false) ; 
addParameter(p,'Subtitle',false) ; 
addParameter(p,'lg',false) ; 
addParameter(p,'Place','R') ; 
addParameter(p,'fig3D',false) ; 
% Specifics
addParameter(p,'FontSize',18) ; 
addParameter(p,'Square',false) ; 
% Colorbar
addParameter(p,'ColorBar',false) ; 
addParameter(p,'cbType','cmapGen2') ; 
addParameter(p,'cbRev',false) ; 

parse(p,varargin{:}) ; 
% Figure
titleBool = p.Results.Title ; 
subtitleBool = p.Results.Subtitle ; 
lgBool = p.Results.lg ; 
placeLocation = p.Results.Place ; 
f3Dbool = p.Results.fig3D ; 
% Specifics
fontSize = p.Results.FontSize ; 
squareBool = p.Results.Square ; 
% Colorbar
cbBool = p.Results.ColorBar ; 
if cbBool == true , cbN = 100 ; elseif max(cbBool == false) , cbBool = false ; else , cbBool = true ; cbN = p.Results.ColorBar ; end
cbType = p.Results.cbType ; 
cbRevBool = p.Results.cbRev ; 

varargout{1} = p.Results ; 

%% Create Figure
fg = figure ; 
fg.Position([3,4]) = standardRes("WVGA") ; % Dual Column Paper
if squareBool , fg.Position([3,4]) = standardRes("SQFHD")/4 ; end
figPlace(fg,placeLocation) ; % Place it centrally on the RH Monitor
fg.Theme = 'light' ; % If using New Desktop

%% Axes
ax = axes ; 
colororder('k') ; % Only plot in black by default
ax.Box = 'on' ; 
ax.FontSize = fontSize ; ax.XAxis.FontSize = fontSize ; ax.YAxis.FontSize = fontSize ; ax.ZAxis.FontSize = fontSize ; 
hold on ; ax.LineWidth = 2 ; grid on ; grid('minor') ; 
if any(version('-release')==["2023b","2024a","2024b"]) , ax.GridLineWidth = 1 ; end
xlabel("x",'FontSize',fontSize+2,'Color','k') ; ylabel("y",'FontSize',fontSize+2,'Color','k') ; zlabel("z",'FontSize',fontSize+2,'Color','k') ; 

%% Legend
if lgBool 
    lg = legend('Orientation','Horizontal','Location','southoutside','FontSize',fontSize-2,'TextColor','k') ; 
    ax.Units = 'normalized' ; 
    ax.Position(2) = ax.Position(2)-0.1 ; ax.Position(4) = ax.Position(4)+0.1 ; 
else , lg = [] ; end

%% Extras
if titleBool 
    title(ax,"Title",'FontSize',fontSize+6) ; 
    ax.Position(4) = ax.Position(4)-0.08 ; ax.Position(2) = ax.Position(2)+0.06 ; 
    if lgBool , ax.Position(2) = ax.Position(2)-0.06 ; end
end
if subtitleBool 
    subtitle(ax,"Subtitle",'FontSize',fontSize+2) ; 
    ax.Position(4) = ax.Position(4)-0.04 ; 
    if titleBool , ax.Position(4) = ax.Position(4)-0.01 ; end
end

%% ColorBar
if cbBool
    colList = eval(cbType+"(cbN)") ; if cbRevBool , colList = colList(end:-1:1,:) ; end , colormap(colList) ; 
    colorBar = colorbar(ax,"eastoutside",'Ticks',linspace(0,1,cbN+1),'TickLabelInterpreter','latex','FontSize',fontSize-4) ; 
    ax.Position(1) = ax.Position(1)-0.025 ; ax.Position(3) = ax.Position(3)-0.04 ; 
    if cbN < 25
        colorBar.TickLabels(1) = {""} ; 
        for i = 2 : length(colorBar.TickLabels)
            colorBar.TickLabels(i) = {"u"+(i-1)} ; 
        end
    else
        for i = 1 : length(colorBar.TickLabels)
            colorBar.TickLabels(i) = {""} ; 
        end
    end
    varargout{1}.cBar = colorBar ; 
    if squareBool , ax.Position(3) = ax.Position(3)-0.1 ; ax.Position(1) = ax.Position(1)+0.05 ; end
end

%% 3D
if f3Dbool
    view(45,(180*asin(1/sqrt(3)))/pi) ; 
    ax.Position(2) = ax.Position(2)-0.02 ; 
    ax.Position(4) = ax.Position(4)+0.025 ;
end

end