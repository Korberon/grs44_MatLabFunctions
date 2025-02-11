function [fg,tl,ax,lg,varargout] = tiledGen(N,M,varargin) 
%% tiledGen.m
%    Generate a tiled layout easily (made to work alongside figGen.m)
%% Inputs   :
%   N       : Number of rows
%   M       : Number of columns
%% Outputs  :
%   fg      : Figure object
%   tl      : Tiled object
%   ax      : Axes objects (1:length(N*M))
%   lg      : Legend object
%
%% Optional Inputs  :
%   General :
%       'Title'=true/false : Create a title object for the tiled layout
%       'Subtitle'=true/false : Create a subtitle object for the tiled layout
%       'lg'=true/false : Create a legend for the tiled layout, targetting lgTile
%       'Place'=figPlace.m : Places the axes in the position (see figPlace.m)
%       'Resolution'=standardRes.m : Sets the resolution type (see standardRes.m)
%   Tiled Layout :
%       'Dicing'=[n,m;n,m;...] : Dicing of the tiled layout, rows and columns in order of left-to-right, top-to-bottom
%       'lgTile'=i : Selects the tile the legend targets
%       'EachTitle'=true/false : Create a title for every tile
%       'EachSubtitle'=true/false : Create a subtitle for every tile
%   Specifics :
%       'FontSize'=u : General font size for the axes object (all text scales relative to this!)
%       'Square'=true/false : The axes are square
%   ColorBar :
%       'ColorBar'=u/false      : Generates a ColorBar with the specified input (either false or N)
%       'cbType'=colorMap       : Sets the colourmap of the Colorbar object (eg. "winter","summer","1-summer" etc.)
%       'cbRev'=true/false      : Reverses the cbType
%% Optional Outputs:
%   cBar : Colorbar object
%   dbgObject : The debugging object (containing all relevant data)
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% 
if nargin == 0 , close all ; N = 2 ; M = 3 ; end

%% Input Handling
p = inputParser() ; 
% Figure
addParameter(p,'Title',false) ; 
addParameter(p,'Subtitle',false) ; 
addParameter(p,'lg',false) ; 
addParameter(p,'Place','R') ; 
addParameter(p,'Resolution','')
% Tiled
addParameter(p,'Dicing',[]) ; 
addParameter(p,'lgTile',inf) ; 
addParameter(p,'EachTitle',false) ; 
addParameter(p,'EachSubtitle',false) ; 
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
% Tiled
dicing = p.Results.Dicing ; 
lgTile = p.Results.lgTile ; 
eachTitleBool = p.Results.EachTitle ; 
eachSubtitleBool = p.Results.EachSubtitle ; 
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
fg.Position([3,4]) = standardRes("SVGA") ; 
if squareBool , fg.Position([3,4]) = standardRes("SQFHD")/3 ; end
fg.Theme = 'light' ; 
figPlace(fg,placeLocation) ; 

%% Tiled Layout
tl = tiledlayout(N,M) ; 

%% Axes
if isempty(dicing) , dicing = ones(N*M,2) ; end 
ax = gobjects(1,size(dicing,1)) ; 
for i = 1 : size(dicing,1)
    ax(i) = nexttile(dicing(i,:)) ; 
    colororder('k') ; % Only plot in black by default
    ax(i).Box = 'on' ; 
    ax(i).FontSize = fontSize ; ax(i).XAxis.FontSize = fontSize ; ax(i).YAxis.FontSize = fontSize ; ax(i).ZAxis.FontSize = fontSize ; 
    hold on ; ax(i).LineWidth = 2 ; grid on ; grid('minor') ; 
    if any(version('-release')==["2023b","2024a","2024b"]) , ax(i).GridLineWidth = 1 ; end
    xlabel(ax(i),"x$_"+i+"$",'FontSize',fontSize+2,'Color','k') ; 
    ylabel(ax(i),"y$_"+i+"$",'FontSize',fontSize+2,'Color','k') ; 
    zlabel(ax(i),"z$_"+i+"$",'FontSize',fontSize+2,'Color','k') ; 
end

%% Legend
if lgBool
    lg = legend(ax(min(lgTile,size(dicing,1))),'Orientation','Horizontal','Location','southoutside','FontSize',fontSize-2,'TextColor','k') ; 
    if max(contains(p.UsingDefaults,'lgTile'))
        lg.Units = 'normalized' ; 
        lg.Position(1) = ax(1).Position(1) ; 
        tl.Position(2) = tl.Position(2) + 0.08 ; 
        tl.Position(4) = tl.Position(4) - 0.05 ; 
    end
else , lg = [] ; end

%% Titles
if titleBool 
    title(tl,"Title",'FontSize',fontSize+6,'Interpreter','latex') ; 
    tl.Position(4) = tl.Position(4) - 0.08 ; 
    if ~lgBool , tl.Position(2) = tl.Position(2) + 0.02 ; tl.Position(4) = tl.Position(4) + 0.05 ; end
end
if subtitleBool 
    subtitle(tl,"Subtitle",'FontSize',fontSize+2,'Interpreter','latex') ; 
    tl.Position(4) = tl.Position(4)-0.05 ; 
end
if eachTitleBool
    tl.Position(4) = tl.Position(4)-0.08 ; 
    for i = 1 : length(ax)
        title(ax(i),"Eachtitle",'FontSize',fontSize+6) ; 
    end
end
if eachSubtitleBool
    tl.Position(4) = tl.Position(4)-0.05 ; 
    for i = 1 : length(ax)
        subtitle(ax(i),"Eachsubtitle",'FontSize',fontSize+2) ; 
    end
end

%% ColorBar
if cbBool
    colList = eval(cbType+"(cbN)") ; if cbRevBool , colList = colList(end:-1:1,:) ; end , colormap(colList) ; 
    colorBar = colorbar(ax(end),"eastoutside",'Ticks',linspace(0,1,cbN+1),'TickLabelInterpreter','latex','FontSize',fontSize-4) ; 
    tl.Position(1) = tl.Position(1)-0.025 ; tl.Position(3) = tl.Position(3)-0.04 ; 
    colorBar.Position(4) = tl.Position(4) ; colorBar.Position(2) = tl.Position(2) ; 
    colorBar.Position(1) = tl.Position(1)+tl.Position(3)+0.05 ; 
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
end

end