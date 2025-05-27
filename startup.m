%% startup.m
% File that runs on startup / when cleared with sodoff.m
%% Inputs   :
%   Will request a path on first run; select the directory where you store your MatLab Functions
%% Outputs  :
%   Will create "myUserProfile.mat" which saves the directory selected by the UI Request

%% Request and Save Generic Path
userProfile = getenv('USERPROFILE');
startPath = mfilename('fullpath') ; startPath = startPath(1:length(startPath)-length(mfilename)) ; 
if ~exist('myUserProfile.mat','file')
    loc = uigetdir(startPath,"Select MatLab Functions Folder Path") ; 
    assert(min(loc(1:length(userProfile))==userProfile),'Unknown User Profile Directory Warning') ; 
    loc = loc(length(userProfile)+1:end) ; 
    save([startPath,'myUserProfile.mat'],'loc') ; 
end

%% Load Path
load([startPath,'myUserProfile.mat'],'loc') ; 
addpath(genpath(fullfile(userProfile,loc))) ; 

%% Graphical Root Settings
set(groot, 'DefaultLineLineWidth',2) ;
set(groot, 'DefaultTextInterpreter','latex');
set(groot, 'DefaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultLegendInterpreter','latex');
set(groot, 'DefaultAxesFontSize',18);

%% Use Light Setting if using Dark-Mode Shell in 2023b Onwards
s = settings;
s.matlab.appearance.figure.GraphicsTheme.TemporaryValue = "light";
clear all ; 

%% Disable Annoying Warnings
warning('off','MATLAB:MKDIR:DirectoryExists') ; 
warning('off','stats:boxplot:BadObjectType') ; 