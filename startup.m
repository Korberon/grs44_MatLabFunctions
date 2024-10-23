userProfile = getenv('USERPROFILE');
addpath(genpath(fullfile(userProfile, 'OneDrive - University of Bath', '(_PhD', 'MatLab Functions')));

set(groot, 'DefaultLineLineWidth',2) ;
set(groot, 'DefaultTextInterpreter','latex');
set(groot, 'DefaultAxesTickLabelInterpreter','latex');
set(groot, 'DefaultLegendInterpreter','latex');
set(groot, 'DefaultAxesFontSize',18);