function varargout = standardRes(resRequest)
%% standardRes.m
%   Reminder / output of the standard monitor resolutions & names
%% Inputs       :
%   resRequst : The Requested resolution name
%% Outputs  :
%   res     : The resolution requested
%% Created by George R. Smith - grs44@bath.ac.uk 

if nargin == 0 , open standardRes ; else

switch resRequest
    %% Rectangulars
    case "CGA" , res = [320,200] ; % 16:10
    case "HVGA" , res = [480,320] ; % 3:2
    case "WVGA" , res = [800,480] ; % 5:3
    case "HD720" , res = [1280,720] ; % 16:9
    case "WXGA" , res = [1280,800] ; % 5:3
    case "WSXGA+" , res = [1680,1050] ; % 16:10
    case "FullHD" , res = [1920,1080] ; % 16:9
    case "2K" , res = [2048,1080] ; case "2KDCI" , res = [2048,1080] ; % 17:9
    case "UWFHD" , res = [2560,1080] ; % 21:9
    case "4K" , res = [3840,2160] ; case "4KUHD" , res = [3840,2160] ; % 16:9
    case "5K" , res = [5120,2880] ; case "5KUHD" , res = [5120,2880] ; % 16:9
    
    %% Squares
    case "QVGA" , res = [320,240] ; % 4:3
    case "VGA" , res = [640,480] ; % 4:3
    % case "PAL" , res = [768,576] ; % 4:3
    case "SVGA" , res = [800,600] ; % 4:3
    case "QuadVGA" , res = [1280,960] ; % 4:3
    case "QXGA" , res = [2048,1536] ; % 4:3
    case "SQFHD" , res = [1920,1920] ; % 1:1
    case "QSXGA" , res = [2560,2048] ; % 5:4
    
    %% Single Axes
    case "SingleAxes" 
        resx = [320,480,640,800,1280,1680,1920,2048,2560,3840,5120] ; 
        resy = [200,240,480,320,480,600,720,800,960,1050,1080,1536,1920,2048,2160,2880] ; 
        res = [[resx,zeros(1,length(resy)-length(resx))];[resy,zeros(1,length(resx)-length(resy))]] ; 
end

%% Output Handling
varargout{1} = res ; 
end