function [t,y] = quickSinusoid(varargin) 

t = 0 : 0.01 : 10 ; 
y = pi*2/3*sin(t*2*pi*1.5+0.1) ; 


if contains("plot",varargin) 
    figGen ; 
    plot(t,y) ; 
    xlabel("Time (s)") ; 
    ylabel("1.5 Hz Signal") ; 
end 