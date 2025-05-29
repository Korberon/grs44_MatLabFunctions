function patchAbsolute(x,y,varargin)
%% No-Input Example
if nargin == 0 
    close all ; 
    if exist('figGen','file') , [~,~] = figGen ; else , figure ; axes ; hold all ; end
    plot(linspace(0,1,14),linspace(0,1,14).^-0.5,'Color','k','LineStyle','none','Marker','x') ; plot(linspace(0,1),linspace(0,1).^-0.5+.1*sin(4*linspace(0,1)),'r') ; 
    x = 4*[0.0418338000000000	0.00515620000000000	0.00515620000000000	0	0	0.00889000000000000	0.00889000000000000	0.0241300000000000	0.0241300000000000	0.0469900000000000	0.0469900000000000	0.0428752000000000	0.0802132000000000	0.0795782000000000	0.0425450000000000	0.0425450000000000	0.0386842000000000	0.0315976000000000	0.00995680000000000	0.00541020000000000	0.0427482000000000	0.0418338000000000] ; 
    y = 4*[0	-0.0470408000000000	-0.0377952000000000	-0.0377952000000000	-0.0494792000000000	-0.0494792000000000	-0.0504952000000000	-0.0504952000000000	-0.0507492000000000	-0.0507492000000000	-0.0458724000000000	-0.0477774000000000	0	0	-0.0473456000000000	-0.0423672000000000	-0.0423672000000000	-0.0456692000000000	-0.0456692000000000	-0.0477774000000000	0	0] ; 
end

%% Optional Inputs
p = inputParser() ; 
% Plotting
addParameter(p,'Scale',1) ; 
addParameter(p,'Corner','tr') ; 
addParameter(p,'ax',gca()) ; 
addParameter(p,'fg',gcf()) ; 
addParameter(p,'Free',false) ; 
addParameter(p,'Equal',true) ; 
addParameter(p,'Padded',true) ; 
addParameter(p,'Padding',0.02) ; 
addParameter(p,'Debug',false) ; 
% Colours
addParameter(p,'Color',[1,1,1]*0) ; 
addParameter(p,'EdgeColor',[]) ; 
addParameter(p,'Alpha',1) ; 
addParameter(p,'LineStyle','none') ; 
addParameter(p,'LineWidth',2) ; 
% Parse
parse(p,varargin{:}) ; 
% Plotting
scaleFactor = p.Results.Scale ; x = x*scaleFactor ; y = y*scaleFactor ; x = x-min(x) ; y = y-min(y) ; 
cornerCase = p.Results.Corner ; 
ax = p.Results.ax ; 
fg = p.Results.fg ; 
freeBool = p.Results.Free ; if length(freeBool)>1 , freeLoc = freeBool ; freeBool = true ; else , if freeBool , warning("What?") ; end , end
equalBool = p.Results.Equal ; 
paddedBool = p.Results.Padded ; 
padding = p.Results.Padding ; 
debugBool = p.Results.Debug ; 
% Colours
faceColor = p.Results.Color ; 
edgeColor = p.Results.EdgeColor ; if isempty(edgeColor) , edgeColor = faceColor ; end
faceAlpha = p.Results.Alpha ; 
lineStyle = p.Results.LineStyle ; 
lineWidth = p.Results.LineWidth ; 

%% Equal Axes
if equalBool
    y = y*(fg.Position(3)/fg.Position(4)) ; 
    xpadding = padding ; ypadding = padding*(fg.Position(3)/fg.Position(4)) ; 
else
    xpadding = padding ; ypadding = padding ; 
end

%% Fake Axes
axFake = axes('Position',ax.Position,'XAxisLocation','bottom','YAxisLocation','right','Color','none','Parent',fg) ; 
axFake.Interactions = [] ; 
% Location
if freeBool
    X1 = freeLoc(1) ; 
    X2 = freeLoc(1)+freeLoc(3) ; 
    Y1 = freeLoc(2) ; 
    Y2 = freeLoc(2)+freeLoc(4) ; 
else
    switch cornerCase
        case "tl"
            X1 = ax.Position(1) ; 
            X2 = ax.Position(1)+max(x) ; 
            Y1 = ax.Position(2)+ax.Position(4)-max(y) ; 
            Y2 = ax.Position(2)+ax.Position(4) ; 
            if paddedBool , X1=X1+xpadding ; X2=X2+xpadding ; Y1=Y1-ypadding ; Y2=Y2-ypadding ; end
        case "tr"
            X1 = ax.Position(1)+ax.Position(3)-max(x) ; 
            X2 = ax.Position(1)+ax.Position(3) ; 
            Y1 = ax.Position(2)+ax.Position(4)-max(y) ; 
            Y2 = ax.Position(2)+ax.Position(4) ; 
            if paddedBool , X1=X1-xpadding ; X2=X2-xpadding ; Y1=Y1-ypadding ; Y2=Y2-ypadding ; end
        case "bl"
            X1 = ax.Position(1) ; 
            X2 = ax.Position(1)+max(x) ; 
            Y1 = ax.Position(2) ; 
            Y2 = ax.Position(2)+max(y) ; 
            if paddedBool , X1=X1+xpadding ; X2=X2+xpadding ; Y1=Y1+ypadding ; Y2=Y2+ypadding ; end
        case "br"
            X1 = ax.Position(1)+ax.Position(3)-max(x) ; 
            X2 = ax.Position(1)+ax.Position(3) ; 
            Y1 = ax.Position(2) ; 
            Y2 = ax.Position(2)+max(y) ; 
            if paddedBool , X1=X1-xpadding ; X2=X2-xpadding ; Y1=Y1+ypadding ; Y2=Y2+ypadding ; end
    end
end

axFake.Position = [X1,Y1,X2-X1,Y2-Y1] ; 
axFake.XGrid = 1 ; axFake.YGrid = 1 ; 
axFake.XLim = [min(x),max(x)] ; axFake.YLim = [min(y),max(y)] ; 

%% Patch
patchOut = patch(axFake,x,y,faceColor,'LineStyle',lineStyle,'LineWidth',lineWidth,'EdgeColor',edgeColor) ; 
patchOut.FaceAlpha = faceAlpha ; 

%% Output Handling
if ~debugBool
    axFake.Visible = 0 ; 
    set(gcf,'CurrentAxes',ax) ; 
end
end