function varargout = quickMSD(varargin)
%% quickMSD.m
%   Generates a Mass-Spring-Damper result, mainly for use in example plots
%% Inputs   :
%   None
%% Outputs  :
%   None
%
%% Optional Inputs  :
%   'M'=kg : Mass
%   'C'=N*s/m : Damping
%   'K'=N/m : Stiffness
%   'Solver'=["Euler","RK4"] : Solver type
%   'dt'=s : Timestep
%   'tStart'=s : Start time
%   'tEnd'=s : End time
%   'tList'=s : Instead of specifying dt, tStart, tEnd, just give the vector yourself
%   'PlotMe'=true/false : Plot the result?
%% Excitation Inputs    :
%   'zInit'=m : Starting amplitude
%   'tMin'=s : Time at which excitation begins
%   's'=["Sinusoid","Step"] : Excitation Shape
%   Sinusoid:
%      'freq'=Hz : Frequency of sinusoid
%       'Excitation'=Complex : Complex number to describe the sinusoid of excitation 2*abs(s)*cos(freq*2*pi*tList+angle(s))
%   Step:
%      'StepHeight'=m : Step Height of excitation
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling
p = inputParser() ; 
addParameter(p,"M",0.1) ; 
addParameter(p,"C",1.2) ; 
addParameter(p,"K",1000) ; 
addParameter(p,"Solver","RK4") ; 
addParameter(p,"dt",0.01) ; 
addParameter(p,"tStart",0) ; 
addParameter(p,"tEnd",2) ; 
addParameter(p,"tList",[]) ;
addParameter(p,"PlotMe",true) ; 
% Excitation
addParameter(p,"s","Sinusoid") ; 
addParameter(p,"freq",2) ; 
addParameter(p,"Excitation",10+2*1j) ; 
addParameter(p,"tMin",0.1) ; 
addParameter(p,"StepHeight",10) ; 
addParameter(p,"zInit",0) ; 

parse(p,varargin{:}) ; 
M = p.Results.M ; 
C = p.Results.C ; 
K = p.Results.K ; 
solver = p.Results.Solver ; 
dt = p.Results.dt ; 
tStart = p.Results.tStart ; 
tEnd = p.Results.tEnd ; 
tList = p.Results.tList ; if max(contains(p.UsingDefaults,"tList")) , tList = tStart:dt:tEnd ; end
plotMe = p.Results.PlotMe ; 
if nargin == 0 , plotMe = true ; end

% Excitation
s = p.Results.s ; 
S = p.Results.Excitation ;
tMin = p.Results.tMin ; 
freq = p.Results.freq ; 
stepHeight = p.Results.StepHeight ; 
if max(isstring(s))
    switch s
        case "Sinusoid"
            s = sin(tList*freq*2*pi+angle(S))*abs(S) ; 
            s(tList<tMin) = 0 ; 
        case "Step"
            s = zeros(size(tList)) ; s(tList>tMin) = stepHeight ; 
    end
end
zInit = p.Results.zInit ; 


%% System
z = zeros(2,length(tList)) ; 
z(:,1) = zInit ; 
dz = zeros(2,length(tList)) ; 
switch solver
    case "Euler"
        for ti = 2 : length(tList)
            dz(:,ti) = odeSolve(z(:,ti-1),M,C,K,s(1,ti-1)) ; 
            z(:,ti) = dz(:,ti)*dt ; 
        end
    case "RK4"
        for ti = 2 : length(tList)
            rkA = odeSolve(z(:,ti-1)         ,M,C,K,s(1,ti-1)) ; 
            rkB = odeSolve(z(:,ti-1)+rkA*dt/2,M,C,K,mean(s(1,[ti-1,ti]))) ; 
            rkC = odeSolve(z(:,ti-1)+rkB*dt/2,M,C,K,mean(s(1,[ti-1,ti]))) ; 
            rkD = odeSolve(z(:,ti-1)+rkC*dt  ,M,C,K,s(1,ti)) ; 

            z(:,ti) = z(:,ti-1)+(rkA+2*rkB+2*rkC+rkD)*dt/6 ; 
        end
end

%% Plotting
if plotMe
    if exist('tiledGen','file') , [fg,tl,ax] = tiledGen(2,1) ; 
    else , fg = figure ; fg.Position = [0,0,1920,1080]/2+[1920,1080,0,0]/4 ; tl = tiledlayout(2,1) ; ax(1) = nexttile ; hold all ; ax(2) = nexttile ; hold all ; end

    xlabel(ax(1),"") ; ylabel(ax(1),"Displacement (m)") ; 
    xlabel(ax(2),"Time (s)") ; ylabel(ax(2),"Force (N)") ; 
    plot(ax(1),tList,z(1,:),'k','HandleVisibility','off')
    plot(ax(2),tList,s(:),'k','HandleVisibility','off')
    
end

%% ODE
function dz = odeSolve(z,M,C,K,s)
    dz = zeros(2,1) ; 
    dz(2) = - (K*z(1)+C*z(2)-s)/M ; 
    dz(1) = z(2) ; 
end

%% Output
varargout{1}.t = tList ; 
varargout{1}.f = s ; 
varargout{1}.y = z(1,:) ; 
varargout{end+1} = p.Results ; 
end