function [fg,ax,t,y,s] = quickMSD(varargin)
M = 100 ; K = 10 ; C = 12 ;
tStart = 0 ; dt = 0.5 ; tEnd = 100 ;
t = tStart : dt : tEnd ; % Time Vector
plotMe = true ; 
for i = 1 : length(varargin)
    if string(varargin{i}) == "M" , M = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "C" , C = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "K" , K = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "tStart" , tStart = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "tEnd" , tEnd = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "dt" , dt = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "signal" , s = varargin{i+1} ; i = i + 1 ;
    elseif string(varargin{i}) == "Plotless" , plotMe = false ; 
    end
end
%% Describe System
t = tStart : dt : tEnd ; % Time Vector
y = zeros(3,length(t)) ; % Initialise state vector
if ~exist('s','var') , s = 0.1*ones(size(t)) ; s(1:floor(length(t)/20)) = 0 ; end 

for ti = 2 : length(t) 
    y(3,ti) = -(K*(y(1,ti-1))+C*y(2,ti-1) - s(ti))/M ; 
    y(2,ti) = y(2,ti-1) + (t(ti)-t(ti-1))*y(3,ti) ; 
    y(1,ti) = y(1,ti-1) + (t(ti)-t(ti-1))*y(2,ti) ; 
end

if plotMe == true 
    [fg,ax] = figGen('lg') ; xlabel("Time (s)") ; ylabel("Response") ;
    plot(t,y(1,:),'k-','LineWidth',1,'DisplayName','Displacement ($\mathrm m$)') ;
    plot(t,y(2,:),'k--','LineWidth',1,'DisplayName','Velocity ($\frac{\mathrm m}{\mathrm s}$)') ;
    plot(t,y(3,:),'k:','LineWidth',1,'DisplayName','Acceleration ($\frac{\mathrm m}{\mathrm s^2}$)') ;
    plot(t,s,'r:','LineWidth',1,'DisplayName','Input') 
    annotation('textbox','Position',[0.828,0.836,0.0765,0.1],'String',["M = "+string(M);"C = "+string(C);"K = "+string(K)],'FontSize',12,'interpreter','latex','BackgroundColor','white')
else
    fg = [] ; ax = [] ; 
end 