function [fg,ax,varargout] = figGen(varargin)
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
%  'square'   : Makes a square figure
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

k = 0 ;
for i = 1 : nargin
    if string(varargin(i)) == "FontSize"
        if i+1 > nargin , error("No Font Size argument") ; end 
        fontSize = str2double(string(varargin(i+1))) ; 
        i = i + 1 ;
    end
    if string(varargin(i)) == "ColorBar"
        if i+1 > nargin , error("No N argument") ; end
        N = str2double(string(varargin(i+1))) ;
        i = i + 1 ;
    end
    if string(varargin(i)) == "cbType"
        if i+1 > nargin , error("No cbType argument") ; end
        cbType = string(varargin(i+1)) ;
        i = i + 1 ;
    end
end
%         end
%     end
% end
% if ~exist('fontSize',"var") , fontSize = 14 ; end % Old Default
if ~exist('fontSize',"var") , fontSize = 18 ; end % Dual Column
% if ~exist('cbType','var') , cbType = 'hsv' ; end 

% fg = figure ; fg.Position = [1920/2,1080/2,1200,600] ; % Old Default 
fg = figure ; fg.Position = [1920/2,1080/2,720,480] ; % Dual Column Paper 
% fg = figure ; fg.Position = [1920/2,1080/2,720,540] ; % Dual Column Paper - Tall 
% fg = figure ; fg.Position = [1920/2,1080/2,720,360] ; % Dual Column Paper - Wide 

if contains("square",string(varargin)) , fg.Position(3) = fg.Position(4) ; end 
fg.Position(1:2) =  fg.Position(1:2)-fg.Position(3:4)/2 ; ax = axes ; colororder('k') ; ax.Box = 'on' ; 
screenSize = sortrows(get(0,'MonitorPositions'), 1) ; fg.Position(1) = screenSize(end,1)+screenSize(end,3)/2 - fg.Position(3)/2 ; 

if contains("Title",string(varargin)) 
    title(ax,"Title",'interpreter','latex','FontSize',fontSize+6) ; 
%     ax.Position(4) = ax.Position(4) ; % Old Default
    ax.Position(4) = ax.Position(4)-0.08 ; 
    ax.Position(2) = ax.Position(2)+0.06 ; 
end 

if contains("Subtitle",string(varargin)) 
    subtitle(ax,"Subtitle",'interpreter','latex','FontSize',fontSize+2) ; 
end

hold on ; ax.LineWidth = 2 ; grid on ; grid('minor') ;  if any(version('-release') == ["2023b","2024a","2024b"]) , ax.GridLineWidth = 1 ; end
ax.FontSize = fontSize ; ax.XAxis.FontSize = fontSize ; ax.YAxis.FontSize = fontSize ; ax.ZAxis.FontSize = fontSize ; ax.TickLabelInterpreter = 'latex' ;
xlabel('x','interpreter','latex','FontSize',fontSize+2,'Color','k') ; ylabel('y','interpreter','latex','FontSize',fontSize+2) ; zlabel('z','interpreter','latex','FontSize',fontSize+2) ; 
set(0,"DefaultLineLineWidth",2) ; 

if contains('lg',string(varargin)) , k = k + 1 ;  
    lg = legend(ax,'interpreter','latex','Orientation','Horizontal','Location','southoutside','FontSize',fontSize-2,'TextColor','k') ; 
    lg.Position(2) = 0.02 ; 
%     ax.Position(2) = lg.Position(2)+lg.Position(4)+0.1 ; ax.Position(4) = ax.Position(4)  ; % Old Default
    ax.Position(2) = lg.Position(2)+lg.Position(4)+0.19 ; ax.Position(4) = ax.Position(4)-0.1  ; % Dual Column
    varargout{k} = lg ;
end
cmapList = cmapGen(100) ; 
colormap(cmapList(end:-1:1,:)) ; 

if contains('ColorBar',string(varargin)) ,  k = k + 1 ;
    % ax.Position([1,3]) = [0.1,0.8] ; 
%     ax.Position(3) = 0.8 ; % Old Default
    if exist('cbType','var') 
        colList = eval(cbType+"(N)") ;
    else 
        try colList = cmapGen(N) ; 
        catch , colList = 1-summer(N) ; disp("No cmapGen.m found, defaulting to 1-Summer. To change this, use 'cbType'") ; 
        end
    end 
    if max(contains(string(varargin),"cbRev")) , colList = colList(end:-1:1,:) ; end 
    colormap(colList) ; 
    cBar = colorbar(ax,'eastoutside','Ticks',linspace(0,1,N+1),'TickLabels',["","Label "+string(1:N)],'TickLabelInterpreter','latex','FontSize',12) ;
%     cBar.Position(3) = cBar.Position(3)-0.005 ; cBar.Position(1) = ax.Position(1)+ax.Position(3)+0.02 ; % Old Default
    % cBar.Position(3) = cBar.Position(3)-0.005 ; cBar.Position(1) = ax.Position(1)+ax.Position(3)+0.1 ; % Dual Column
    ax.Position(3) = 0.725 ; % Dual Paper
    varargout{k} = cBar ;
end