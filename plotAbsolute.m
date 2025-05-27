function lPlot = plotAbsolute(fg,x,y,varargin)
%% plotAbsolute.m
% Script to plot absolute on the figure specified
%% Inputs   :
%   fg      : Figure object
%   x       : x coordinates of plot
%   y       : y coordinates of plot
%% Outputs  :
%   lPlot : The line object
%% Optional Inputs : 
%   Lines
%       LineStyle
%       LineWidth
%       Color
%   Markers
%       Marker
%       MarkerSize
%       MarkerFaceColor
%       MarkerEdgeColor
%   Other   
%       HandleVisibility
%       DisplayName
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling:
if nargin == 0
    if exist('tiledGen','file') , fg = tiledGen ; else , fg = figure ; tl = tiledlayout(2,3) ; ax(1) = nexttile ; ax(2) = nexttile ; ax(3) = nexttile ; ax(4) = nexttile ; ax(5) = nexttile ; ax(6) = nexttile ; end
    x = [0.5,0.75,0.1] ; y = [1,0.5,0.25] ; 
end

%% Input Handling
p = inputParser() ; 

addParameter(p,'LineStyle','-') ; 
addParameter(p,'LineWidth',2) ; 
addParameter(p,'Color','k') ; 

addParameter(p,'Marker','x') ; 
addParameter(p,'MarkerSize',8) ; 
addParameter(p,'MarkerFaceColor','k') ; 
addParameter(p,'MarkerEdgeColor','k') ; 

addParameter(p,'HandleVisibility','off') ; 
addParameter(p,'DisplayName',"AbsPlot") ; 

parse(p, varargin{:}) ; 

fieldList = fields(p.Results) ; 
for n = 1 : length(fieldList) , field = fieldList(n) ; eval(field+" = p.Results."+field+" ; ") ; end

%% Generate Axes
ax = axes('Parent', fg, 'Position', [0, 0, 1, 1], 'Units', 'normalized','XLim', [0, 1], 'YLim', [0, 1], 'Visible', 'off') ; 

%% Plot Line
lPlot = line(ax,x,y,'LineStyle',LineStyle,'LineWidth',LineWidth,'Color',Color,'Marker',Marker,'MarkerSize',MarkerSize,'MarkerFaceColor',MarkerFaceColor,'MarkerEdgeColor',MarkerEdgeColor,'HandleVisibility',HandleVisibility,'DisplayName',DisplayName) ; 

%% Output Handling
if nargout == 0 , clear('lPlot') ; end

end