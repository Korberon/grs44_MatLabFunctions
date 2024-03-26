function [fg,tl,ax,varargout] = tiledGen(N,M,dicing,varargin)
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

if nargin == 0 , N = 2 ; M = 2 ; end 
if nargin == 2 , dicing = ones(N*M,2) ; end 
if size(dicing) == 0 , dicing = ones(N*M,2) ; end 
fontSize = 15 ;

fg = figure ; fg.Position = [(1920-1200)/2,(1080-600)/2,1200,600] ; 
tl = tiledlayout(N,M) ;

if contains("Title",string(varargin)) , title(tl,"Title",'interpreter','latex','FontSize',fontSize+6) ; end
if contains("Subtitle",string(varargin)) , subtitle(tl,"Subtitle",'interpreter','latex','FontSize',fontSize+2) ; end
if contains("fontSize",string(varargin)) , [~,fontSizei] = find(string(varargin) == 'fontSize') ; fontSize = cell2mat(varargin(fontSizei+1)) ; end
if contains("lgTile",string(varargin)) , [~,lgi] = find(string(varargin) == 'lgTile') ; lgTile = cell2mat(varargin(lgi+1)) ; end
if contains("debugging",string(varargin)) , debugging = true ; else , debugging = false ; end 
if debugging == true , fg.Position = [-1919,39,1920,963] ; end 

for i = 1 : nargin -3
    if string(varargin(i)) == "ColorBar"
        if i+1 > nargin , error("No N argument") ; end
        cbN = str2double(string(varargin(i+1))) ;
        i = i + 1 ;
    end 
    if string(varargin(i)) == "cbType"
        if i+1 > nargin , error("No cbType argument") ; end
        cbType = string(varargin(i+1)) ;
        i = i + 1 ;
    end 
end 

ax = gobjects(N,M) ; 
i = 0 ; 
k = 0 ; 
for m = 1 : M 
    for n = 1 : N 
        i = i + 1 ; 
        if i <= size(dicing,1)
            ax(n,m) = nexttile(dicing(i,:)) ; ax(n,m).Box = 'on' ; colororder(ax(n,m),'k') ; 
            if contains("Eachtitle",string(varargin)) , title(ax(n,m),"Title",'interpreter','latex','FontSize',fontSize+6) ; end
            if contains("Eachsubtitle",string(varargin)) , subtitle(ax(n,m),"Subtitle",'interpreter','latex','FontSize',fontSize+2) ; end
            hold all ; ax(n,m).LineWidth = 2 ; grid on ;  if version('-release') == "2023b" , ax(n,m).GridLineWidth = 1 ; end ; grid('minor') ;
            xlabel('x','interpreter','latex','FontSize',fontSize+2) ; ylabel('y','interpreter','latex','FontSize',fontSize+2) ; zlabel('z','interpreter','latex','FontSize',fontSize+2) ; 
            if debugging == true 
                ax(n,m).XLabel.String = "" ; ax(n,m).YLabel.String = "" ; ax(n,m).ZLabel.String = "" ; 
            end 
            ax(n,m).TickLabelInterpreter = 'latex' ; ax(n,m).XAxis.FontSize = fontSize+2 ; ax(n,m).YAxis.FontSize = fontSize+2 ;
            colormap(cmapGen(100)) ; 
        end 
    end
end 
if contains('lg',string(varargin)) , k = k + 1 ;  
    if exist('lgTile')
        lg = legend(ax(lgTile),'Orientation','horizontal','Location','southoutside','interpreter','latex','FontSize',fontSize) ; lg.Layout.Tile = 'South' ;
    else
        lg = legend('Orientation','horizontal','Location','southoutside','interpreter','latex','FontSize',fontSize) ; lg.Layout.Tile = 'South' ;
    end
    varargout{k} = lg ;
end

if contains('ColorBar',string(varargin)) ,  k = k + 1 ; 
    if exist('cbType','var') 
        colList = eval(cbType+"(cbN)") ; 
    else 
        colList = cmapGen(cbN) ; 
    end 
    if max(contains(string(varargin),"cbRev")) , colList = colList(end:-1:1,:) ; end 
    colormap(colList) ; 
    cBar = colorbar(ax(end),'eastoutside','Ticks',linspace(0,1,cbN+1),'TickLabels',["","Label "+string(1:cbN)],'TickLabelInterpreter','latex','FontSize',12) ;
    cBar.Position(3) = cBar.Position(3)-0.005 ; cBar.Position(4) = ax(1).Position(2)+ax(1).Position(4)- ax(end).Position(2) ; 
    varargout{k} = cBar ;
end