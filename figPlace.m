function figPlace(fg,direction) 
%% figPlace.m 
%   Function to move the specified figure to a place on a monitor 
%   Works for either 2 or 3 monitor setups 
%% Inputs   : 
%   fg        : Figure Handle 
%   direction : Specify the Location 
% 
%% Directions : 
% So long as the direction input contains the relevant letter, formatting doesn't matter 
% 
% "L"/"M"/"R"   - Left / Middle / Right Monitor 
% 
% "t/b"         - Top or Bottom halves of monitors 
% "l/r"         - Left or Right Halves of monitors 
% 
% "T"           - Tall (covers height of the specified monitor) 
% "W"           - Wide (covers width of the specified monitor) 
% 
%% Example Code 
%   fg = figure ; figPlace(fg,"R.tl") ; 
%   fg = figure ; figPlace(fg,"tlR") ; 
%   fg = figure ; figPlace(fg,"tRl") ; 
%   fg = figure ; figPlace(fg,"MTW") ; 
%   fg = figure ; figPlace(fg,"MtW") ; 
%
%% Created by George R. Smith - grs44@bath.ac.uk 

    %% Input Handling 
    direction = char(direction) ; 

    %% Get the Screen Size of Monitors and Order Them
    screenSize = sortrows(get(0,'MonitorPositions'), 1) ; 
    % Remove the top / bottom segments
    screenSize(:,4) = screenSize(:,4) - 91 ; 
    screenSize(:,2) = screenSize(:,2) + 40 ; 
    
    %% Which Monitor? 
    if contains(direction,"L") 
        screenIndex = 1 ; 
    elseif contains(direction,"R") 
        screenIndex = size(screenSize,1) ; 
    elseif contains(direction,"M") 
        screenIndex = 2 ; 
        if size(screenSize,1) == 1 , screenIndex = 1 ; end 
    end 
    fg.Position(1) = screenSize(screenIndex,1)+screenSize(screenIndex,3)/2-fg.Position(3)/2 ; 
    fg.Position(2) = screenSize(screenIndex,2)+screenSize(screenIndex,4)/2-fg.Position(4)/2 ; 
    
    %% Position? 
    if contains(direction,"t") 
        fg.Position(4) = screenSize(screenIndex,4)/2-40 ; 
        fg.Position(2) = screenSize(screenIndex,2)+fg.Position(4)+80 ; 
    elseif contains(direction,"b") 
        fg.Position(4) = screenSize(screenIndex,4)/2-40 ; 
        fg.Position(2) = screenSize(screenIndex,2) ; 
    end 

    if contains(direction,"l") 
        fg.Position(1) = screenSize(screenIndex,1) ; 
        fg.Position(3) = screenSize(screenIndex,3)/2 ; 
    elseif contains(direction,"r") 
        fg.Position(3) = screenSize(screenIndex,3)/2 ; 
        fg.Position(1) = screenSize(screenIndex,1)+screenSize(screenIndex,3)/2 ; 
    end 

    %% Scale?
    if contains(direction,"T") 
        fg.Position(4) = screenSize(screenIndex,4) ; 
        fg.Position(2) = screenSize(screenIndex,2) ; 
    end 
    if contains(direction,"W") 
        fg.Position(3) = screenSize(screenIndex,3) ; 
        fg.Position(1) = screenSize(screenIndex,1) ; 
    end 
    
end 
