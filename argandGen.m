function [fg,ax,lg] = argandGen(varargin)
%% argandGen.m
% Very simple couple of lines of code to just set up an Argand diagram
%% Inputs   :
% None
%% Outputs  :
% fg        : Figure object
% ax        : Axes object
% lg        : Legend object
%% Optional Inputs  :
% See figGen for details
%% Example Code :
% argandGen() ; 
% argandGen('lg',true) ; 
% [fg,ax] = argandGen('Title',true) ; ax.Position(1) = 0.2 ; title("Hysteresis") ; tList = 0:2^-13:20 ; plot(cos(tList*2*pi*15+0.1)*0.5,sin(tList*2*pi*15+1.31)*0.5)

[fg,ax,lg] = figGen('Square',true,varargin{:}) ;
xlabel("Re") ; ylabel("Im") ; 
xline(0,'LineWidth',1,'Color','k','Alpha',1,'HandleVisibility','off') ; yline(0,'LineWidth',1,'Color','k','Alpha',1,'HandleVisibility','off') ; 
axis equal 