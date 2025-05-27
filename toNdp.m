function str = toNdp(num,N)
%% toNdp.m
%   Converts a number to N decimal places because I always forget how sprintf works :)
%% Inputs   :
%   num     : The number
%   N       : The number of decimal places
%% Outputs  :
%   str     : The number (as a string)
%
%% Created by George R. Smith - grs44@bath.ac.uk 
str = sprintf("%0."+N+"f",num) ;

end