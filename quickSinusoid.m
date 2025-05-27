function varargout = quickSinusoid(varargin) 
%% quickSinusoid.m
%   Generates a quick sinusoid
%% Inputs   : 
%   None
%% Outputs  :
%   t       : Time vector (s)
%   y       : Distance vector (m)
%
%% Optional Inputs  :
%   'PlotMe'=true/false : Plot the result
%   'ax'=[]/axObj : ax Object
%   'tMin'=s : Start time
%   'tMax'=s : End time
%   'dt'=s : Timestep
%   'tList'=s : Vector of time
%   'freq'=Hz : Frequency of sinusoid
%   'Y'=complex : Complex number describing the sinusoid
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling
p = inputParser() ; 
addParameter(p,'PlotMe',false) ; 
addParameter(p,'ax',[]) ; 
addParameter(p,'tMin',0) ; 
addParameter(p,'tEnd',20) ;
addParameter(p,'dt',2^-13) ; 
addParameter(p,"tList",[]) ; 
addParameter(p,'freq',1) ; 
addParameter(p,'Y',2/3+0.1*1j) ; 
parse(p,varargin{:}) ; 
plotMeBool = p.Results.PlotMe ; if nargin == 0 , plotMeBool = true ; end
ax = p.Results.ax ; 
tMin = p.Results.tMin ; 
tEnd = p.Results.tEnd ; 
dt = p.Results.dt ; 
tList = p.Results.tList ; if isempty(tList) , tList = tMin:dt:tEnd ; end
freq = p.Results.freq ; 
Y = p.Results.Y ; 

%% Generate the Sinusoid 
y = 2*abs(Y)*cos(tList*2*pi*freq+angle(Y)) ; 
if plotMeBool
    if isempty(ax) , if exist('figGen','file') , [fg,ax] = figGen ; else , fg = figure ; ax = axes ; hold all ; end 
    plot(ax,tList,y,'k') ; 
    xlabel("Time (s)") ; 
    ylabel(freq+" Hz Signal") ; 
end
if nargout == 1
varargout{1} = y ; 
elseif nargout >1
    varargout{1} = tList ; 
    varargout{2} = y ; 
end

end