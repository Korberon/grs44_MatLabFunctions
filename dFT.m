function [Y,varargout] = dFT(t, y, f) 
%% dFT.m 
%   Simple Discrete Fourier Transform Code to target specific frequencies around a given point 
%% Inputs   : 
%    t      : Time Data                                     (s) 
%    y      : Input Data                                    (u) 
%    f      : Target Frequency                              (Hz) 
%% Outputs  : 
%    Y      : Fourier Transform of Y                        (U) 
%             [Positive phase from cosine] 
%
%% Optional Inputs  : 
%   None
%% Optional Outputs :
%   unitCircle      : The unit circle over time, at the given frequency
%   Yt2             : The Fourier Transform over time, at the given frequency
%
%% Created by George R. Smith - grs44@bath.ac.uk 

if length(t) == 1 , dt = t ; else , dt = mean(t(2:end)-t(1:end-1)) ; end

if size(y,1) == 1 , nList = (1:length(y)) ; else , nList = (1:length(y))' ; end

unitCircle = exp(-1j*2*pi*f*nList*dt) ; 
Yt2 = y.*exp(-1j*2*pi*f*nList*dt) ; 
Y = sum( y.*exp(-1j*2*pi*f*nList*dt) ) ; 

Y = Y / length(y) ; % Normalising 
varargout{1} = unitCircle ; 
varargout{2} = Yt2 ; 
end 