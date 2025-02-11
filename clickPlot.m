function [xOut,yOut] = clickPlot(fileName,varargin)
%% clickPlot.m
% Generates the data based on your pointer clicks on an image
%% Inputs   : 
% fileName  : Name of the image file
%% Clicks   :
% First     : First click specifies the origin
% Second    : Second click specifies the maximum x position
% Third     : Third click specifies the maximum y position
%% Outputs  :
% xOut      : x coordinates, based on clicks [0-1]
% yOut      : y coordinates, based on clicks [0-1]
%
%% Optional Inputs  :
% 'PlotMe'=true/false : Plot the data once done
% 'XLim'=[min,max] : Maximum and minimum x values on the plot
% 'YLim'=[min,max] : Maximum and minimum y values on the plot
%
%% Created by George R. Smith - grs44@bath.ac.uk 

p = inputParser() ; 
addParameter(p,'PlotMe',true) ; 
addParameter(p,'XLim',[0,1]) ; 
addParameter(p,'YLim',[0,1]) ; 

parse(p,varargin{:}) ; 
plotMeBool = p.Results.PlotMe ; 
YLim = p.Results.YLim ; 
XLim = p.Results.XLim ; 

img = imread(fileName) ; 

image(img) ; 

x = [] ; 
y = [] ; 

playBool = true ; 
while playBool
    [x(end+1),y(end+1),buttonPress] = ginput(1) ; 
    if buttonPress ~= 1 , playBool = false ; end
        
end

x = x-min(x) ; x = x/max(x) ; x = (x+XLim(1))*(XLim(2)-XLim(1)) ; 
y = y-min(y) ; y = y/max(y) ; y = 1 - y ; y = (y+YLim(1))*(YLim(2)-YLim(1)) ; 

xOut = x(4:end-1) ;
yOut = y(4:end-1) ; 

if plotMeBool
    figGen ; 
    plot(xOut,yOut,'LineStyle','none','Marker','x') ; 
end


end