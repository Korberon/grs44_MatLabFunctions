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

%% Input Handling
if nargin == 0 , fileName = [] ; end
if or(nargin == 0,isempty(fileName)) , [fileName,location] = uigetfile({'*.png;*.jpeg','Image files'}) ; fileName = [location,fileName] ; end

%% Variable Inputs
p = inputParser() ; 
addParameter(p,'PlotMe',true) ; 
addParameter(p,'PlotLive',true) ; 
addParameter(p,'XLim',[0,1]) ; 
addParameter(p,'YLim',[0,1]) ; 

parse(p,varargin{:}) ; 
plotMeBool = p.Results.PlotMe ; 
plotLiveBool = p.Results.PlotLive ; 
YLim = p.Results.YLim ; 
XLim = p.Results.XLim ; 

%% Read Image
img = imread(fileName) ; 

%% Plot Image for Clicking
fg = figure ; 
screenSize = sortrows(get(0,'MonitorPositions'), 1) ; 
fg.Position = screenSize(end,:) ; 

image(img) ; 
axis equal ; 
hold all ; 

%% Get Data
x = [] ; 
y = [] ; 

playBool = true ; 
while playBool
    [x(end+1),y(end+1),buttonPress] = ginput(1) ; 
    if buttonPress ~= 1 , playBool = false ; 
    end
    if min([ buttonPress == 1 , length(x)>3 , plotLiveBool ])
        plot(x(end),y(end),'Color',[1,1,1]*1,'Marker','x','Markersize',16,'LineWidth',6) ; 
        plot(x(end),y(end),'Color',[1,1,1]*0,'Marker','x','Markersize',12,'LineWidth',3) ; 
    end
end
hold all ; 
plot(x(4:end-1),y(4:end-1),'Color','k','Marker','x','Markersize',12,'LineWidth',3) ; 
xline(x(1),'Color','k','LineStyle','--','Linewidth',2) ; 
xline(x(2),'Color','k','LineStyle','--','Linewidth',2) ; 
yline(y(1),'Color','k','LineStyle','--','Linewidth',2) ; 
yline(y(3),'Color','k','LineStyle','--','Linewidth',2) ; 
ax = gca() ; 
drawnow ; 
xLimSave = ax.XLim ; yLimSave = ax.YLim ; 
patchIn = patch([xLimSave(1),xLimSave(1),x(2),x(2)],[yLimSave(2),y(1),y(1),yLimSave(2)],[1,1,1]*0.1) ; patchIn.FaceAlpha = 0.2 ; patchIn.LineStyle = 'none' ; 
patchIn = patch([x(2),x(2),xLimSave(2),xLimSave(2)],[yLimSave(2),y(3),y(3),yLimSave(2)],[1,1,1]*0.1) ; patchIn.FaceAlpha = 0.2 ; patchIn.LineStyle = 'none' ; 
patchIn = patch([x(1),x(1),xLimSave(2),xLimSave(2)],[yLimSave(1),y(3),y(3),yLimSave(1)],[1,1,1]*0.1) ; patchIn.FaceAlpha = 0.2 ; patchIn.LineStyle = 'none' ; 
patchIn = patch([xLimSave(1),xLimSave(1),x(1),x(1)],[y(1),yLimSave(1),yLimSave(1),y(1)],[1,1,1]*0.1) ; patchIn.FaceAlpha = 0.2 ; patchIn.LineStyle = 'none' ; 
xlim(xLimSave) ; ylim(yLimSave) ; 

x = x-min(x([1,3])) ; x = x/x(2) ; x = x*(XLim(2)-XLim(1))+XLim(1) ; 
y = y-min(y([1,2])) ; y = y/y(3) ; y = y*(YLim(2)-YLim(1))+YLim(1) ; 

xOut = x(4:end-1) ;
yOut = y(4:end-1) ; 

if plotMeBool
    if exist('figGen','file') , figGen('Place','Rtl') ; else , fg = figure() ; fg.Position = screenSize(end,:) ; end
    plot(xOut,yOut,'LineStyle','none','Marker','x') ; 
end

end