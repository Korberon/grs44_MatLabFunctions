function varargout = annoTable(fg,xywh,nRows,nCols,varargin)
%% annoTable.m 
%   Creates a table of data to annotate a figure
%% Inputs       :
%   fg          : Figure Object
%   xywh        : Position (relative to tile)
%   nRows       : Number of Rows in Table
%   nCols       : Number of Cols in Table
%% Outputs  :
%   an      : Annotation object [nRows,nCols]
%   tx      : Text object       [nRows,nCols]   : Only if Square is True
%
%% Optional Inputs  :
%   'Corner'=["tl","tr","bl","br"]    : Which corner of the axes object to snap to
%   'Square'=true/false   : Whether to add squares into each table box
%   'Tile'=n  : Which tile (of a tiled layout) to target for 'Corner'
%   'Free'=true/false : Whether the annoTable is free or fixed (whether it snaps to a corner, or its position is absolue to the figure)
%% Example Code :
%   annoTable() ; 
%   fg = figure ; annoTable(fg,[0,0,0.2,0.1]) ; 
%   fg = figure ; ax = axes ; [an,tx] = annoTable(fg,[0,0,0.35,0.3],3,1) ; an(1).BackgroundColor = 'none' ; an(1).Color = 'k' ; an(1).String = "M" ; tx(1).String = "1 kg" ; an(2).BackgroundColor = 'none' ; an(2).Color = 'k' ; an(2).String = "C" ; tx(2).String = "2 N s m$^{-1}$" ; an(3).BackgroundColor = 'none' ; an(3).Color = 'k' ; an(3).String = "K" ; tx(3).String = "1.6 kN m$^{-1}$" ;
%   fg = figure ; ax = axes ; [an,tx] = annoTable(fg,[0.3,0.2,0.35,0.3],3,1,'Free',true) ; an(1).BackgroundColor = 'none' ; an(1).Color = 'k' ; an(1).String = "M" ; tx(1).String = "1 kg" ; an(2).BackgroundColor = 'none' ; an(2).Color = 'k' ; an(2).String = "C" ; tx(2).String = "2 N s m$^{-1}$" ; an(3).BackgroundColor = 'none' ; an(3).Color = 'k' ; an(3).String = "K" ; tx(3).String = "1.6 kN m$^{-1}$" ;
%   fg = figure ; ax = axes ; [tx] = annoTable(fg,[0.3,0.2,0.25,0.3],3,1,'Square',false) ; tx(1).String = "1 kg" ; tx(2).String = "2 N s m$^{-1}$" ; tx(3).String = "1.6 kN m$^{-1}$" ;
%   fg = figure ; ax = axes ; [tx] = annoTable(fg,[0.3,0.2,0.25,0.3],3,1,'Square',false,'Corner','bl') ; tx(1).String = "1 kg" ; tx(2).String = "2 N s m$^{-1}$" ; tx(3).String = "1.6 kN m$^{-1}$" ;
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling
p = inputParser() ; 
% Optional Inputs: 
addParameter(p,'Corner','tl');
addParameter(p,'Square',true);
addParameter(p,'Tile',false);
addParameter(p,'Free',false);
% Parse Completion:
parse(p,varargin{:});
Corner = p.Results.Corner;
Square = p.Results.Square;
Tile = p.Results.Tile;
Free = p.Results.Free ; 

if nargin == 0 
    close all ; 
    [fg,tlTest,axTest] = tiledGen(3,3,'Dicing',[3,1;1,2;2,2]) ; 
    xywh = [0,0,0.43,0.15] ; 
    nRows = 2 ; 
    nCols = 3 ; 
    Corner = 'tr' ; 
    Square = true ; 
    Tile = 3 ; 
end
%% Geometry
if Tile ~= false
    tileNo = Tile;
    ax = fg.Children.Children;
    % for i = 1 : length(axes) , ax(i) = axes(end+1-i) ; end
    ax = ax(end:-1:1) ; 
    if ~exist('ax','var') , ax = fg.Children(end) ; end
    thisAxis = ax(tileNo);
    FontSize = thisAxis.FontSize ; 
else
    thisAxis = fg.Children ; 
    try FontSize = thisAxis.FontSize ; 
    catch
        FontSize = thisAxis.Children(end).FontSize ; 
    end
end
% We have which axis, and where
if Free
    X1 = xywh(1) ; Y1 = xywh(2) ; 
else
    switch Corner
        case "bl"
            X1 = thisAxis.Position(1) ; 
            Y1 = thisAxis.Position(2) ; 
        case "br"
            X1 = thisAxis.Position(1)+thisAxis.Position(3)-xywh(3) ; 
            Y1 = thisAxis.Position(2) ; 
        case "tl"
            X1 = thisAxis.Position(1) ; 
            Y1 = thisAxis.Position(2)+thisAxis.Position(4)-xywh(4) ; 
        case "tr"
            X1 = thisAxis.Position(1)+thisAxis.Position(3)-xywh(3) ; 
            Y1 = thisAxis.Position(2)+thisAxis.Position(4)-xywh(4) ; 
    end
end
X2 = X1+xywh(3) ; 
Y2 = Y1+xywh(4) ; 

%%
if Square == true , colList = cmapGen2(nRows*nCols+1) ; colList = colList(2:end,:) ; end
i = 0 ; 
for n = 1 : nRows
    for m = 1 : nCols
        i = i + 1 ; 
        RootC = [X1+xywh(3)/nCols*(m-1),Y2-xywh(4)*n/nRows] ; 
        if Square
            SquareC = [RootC,xywh(4)/nRows,xywh(4)/nRows] ; SquareC(3) = SquareC(3) * fg.Position(4)/fg.Position(3) ; 
            SquareC = min(SquareC,1) ; SquareC = max(SquareC,0) ; 
            TextC = [SquareC(1:2),0,SquareC(4)] + [SquareC(3),0,xywh(3)/nCols-SquareC(3),0] ; 
            TextC = min(TextC,1) ; TextC = max(TextC,0) ; 
            an(n,m) = annotation(fg,"Textbox",SquareC,'BackgroundColor',colList(i,:),'String',"",'FontSize',FontSize,'Interpreter','latex','Color','w');
            tx(n,m) = annotation(fg,"Textbox",TextC,'BackgroundColor','w','String',"("+n+","+m+")",'FontSize',FontSize,'Interpreter','latex');
        else
            SquareC = [RootC,xywh(4)/nRows,xywh(4)/nRows] ; SquareC(3) = SquareC(3) * fg.Position(4)/fg.Position(3) ; 
            TextC = [SquareC(1:2),0,SquareC(4)] + [SquareC(3),0,xywh(3)/nCols-SquareC(3),0] ; 
            TextC = [RootC,xywh(3)/nCols,xywh(4)/nRows] ; 
            tx(n,m) = annotation(fg,"Textbox",TextC,'BackgroundColor','w','String',"TST",'FontSize',FontSize,'Interpreter','latex');
        end
    end
end
if Square
    varargout{1} = an ; 
    varargout{2} = tx ; 
else
    varargout{1} = tx ; 
end
