function fDate = getDate() 
%% getDate.m
%   Very advanced bit of code that returns the date :)
%% Inputs   :
%   None
%% Outputs  :
%   Current Date (yy.mm.dd)
%
%% Created by George R. Smith - grs44@bath.ac.uk 

fDate = datestr(datetime('now'), 'yy.mm.dd') ; 
end