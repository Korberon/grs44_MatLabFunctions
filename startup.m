userProfile = getenv('USERPROFILE');
startPath = mfilename('fullpath') ; startPath = startPath(1:length(startPath)-length(mfilename)) ; 
if ~exist('myUserProfile.mat','file')
    loc = uigetdir(startPath,"Select MatLab Functions Folder Path") ; 
    assert(min(loc(1:length(userProfile))==userProfile),'Unknown User Profile Directory Warning') ; 
    loc = loc(length(userProfile)+1:end) ; 
    save([startPath,'myUserProfile.mat'],'loc') ; 
end
load([startPath,'myUserProfile.mat'],'loc') ; 
addpath(genpath(fullfile(userProfile,loc))) ; 
warning('off','MATLAB:MKDIR:DirectoryExists') ; 

set(groot, 'DefaultLineLineWidth',2) ;
set(groot, 'DefaultTextInterpreter','latex');
set(groot, 'DefaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultLegendInterpreter','latex');
set(groot, 'DefaultAxesFontSize',18);

s = settings;
s.matlab.appearance.figure.GraphicsTheme.TemporaryValue = "light";
clear all ; 

%% Disable Warnings
warning('off','stats:boxplot:BadObjectType') ; 