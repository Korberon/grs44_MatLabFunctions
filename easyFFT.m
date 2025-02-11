function [F,Y,varargout] = easyFFT(dt,y,varargin)
%% easyFFT.m
% Easily generate an FFT for a given signal (I cba to remember every time how it works)
%% Inputs   :
%   dt      : Timestep (s)
%   y       : Signal (u)
%% Outputs  :
%   F       : Frequencies (Hz)
%   Y       : FFT(y)
%% Optional Inputs  :
%   'PlotMe'=true/false : Plot or not
%% Optional Outputs :
%   A(u) : Amplitude of signal FFT
%   Phi(rad) : Phase of signal FFT
%   dbg : Debugging object, containing all relevant data
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling:
p = inputParser() ; 
addParameter(p,'PlotMe',false);
parse(p,varargin{:}) ; 
plotMe = p.Results.PlotMe;

if nargin == 0 
    dt = 2^-13 ; t = 0:dt:20 ; 
    y = sin(t*2*pi*30+0.3)*0.015 + sin(t*2*pi*60+0.7)*0.003 ; 
    plotMe = true ; 
end

%% FFT:
N = length(y) ; 
Y = fft(y) ; 
Y = Y(1:floor(N/2+1)) ; 
F = (0:N/2)/dt/N ; 

if or(nargout>2,nargin==0)
    A = abs(Y)/N ; varargout{1} = A ; 
    Phi = angle(Y) ; varargout{2} = Phi ; 
end

%% Plotting:
if plotMe == true
    [fg,tl,ax] = tiledGen(2,1,'Dicing',[]) ; 
    plot(ax(1),F,2*A) ; 
    plot(ax(2),F,Phi*180/pi) ; 
    xlim(ax,[10,200]) ; 
    xlabel(ax(1),"") ; xlabel(ax(2),axLab("Frequency")) ; 
    ylabel(ax(1),"abs(Y)") ; ylabel(ax(2),"ang(Y)") ; 
    if nargin == 0
        plot(ax(1),30,0.015,'Marker','x','MarkerEdgeColor','r') ; 
        plot(ax(1),60,0.003,'Marker','x','MarkerEdgeColor','r') ; 
        plot(ax(2),30,0.3*180/pi,'Marker','x','MarkerEdgeColor','r') ; 
        plot(ax(2),60,0.7*180/pi,'Marker','x','MarkerEdgeColor','r') ; 
    end
    if nargout > 2
        varargout{end+1}.fg = fg ; 
        varargout{end}.tl = tl ; 
        varargout{end}.ax = ax ; 
    end
end
