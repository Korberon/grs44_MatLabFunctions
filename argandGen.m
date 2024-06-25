function [fg,ax,lg] = argandGen(varargin)
lg = [] ; 
if contains(varargin,"lg") , [fg,ax,lg] = figGen('square',varargin) ; else , [fg,ax] = figGen('square') ; end 
xlabel("Re") ; ylabel("Im") ; 
xline(0,'LineWidth',1,'Color','k','Alpha',1,'HandleVisibility','off') ; yline(0,'LineWidth',1,'Color','k','Alpha',1,'HandleVisibility','off') ; 
% plot(0.001,0.001) ; 
% plot(-0.001,-0.001) ; 
axis equal 