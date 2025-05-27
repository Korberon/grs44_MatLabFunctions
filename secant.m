function gNext = secant(guesses,errors,varargin)
%% secant.m
%   Secant Method (linear descent) for iterative solving
%% Inputs   :
%   guesses : List of guesses (will ignore NaN or inf and auto-work out limits)
%   errors  : List of errors  (will ignore NaN or inf and auto-work out limits)
%% Outputs  :
%   gNext   : Next guess ie. guesses(end+1)
%% Optional Inputs  :
%   PlotMe          : Plot the results in a graph
%   PlotHere        : If enabled, will plot on the active / external graph, rather than on its own separate graph
%   tol             : Tolerance limits plotted on graph (NOT used for outputs!)
%% Example Code :
%   close all ; guesses = [0,0.1] ; errors = [1.2,0.5] ; gNext = secant(guesses,errors,'PlotMe',true) ; 
%   close all ; guesses = [0,0.1,0.2,0.2429] ; errors = [1.2,0.5,0.15,0.03] ; gNext = secant(guesses,errors,'PlotMe',true) ;
%   close all ; guesses = [0,0.1,0.2,0.2429] ; errors = [1.2,0.5,0.15,0.03] ; gNext = secant(guesses,errors,'PlotMe',true,'tol',0.1) ;
%
%% Created by George R. Smith - grs44@bath.ac.uk 

%% Input Handling
% No-input Example
if nargin == 0 
    guesses = [0,0.1,0.2,0.2429] ; errors = [1.2,0.5,0.15,0.03] ; 
    varargin = {'PlotMe',true,'tol',0.1} ; 
end

% Remove NaN / inf
guesses = guesses(~isinf(guesses)) ; guesses = guesses(~isnan(guesses)) ; 
errors = errors(~isinf(errors)) ; errors = errors(~isnan(errors)) ; 

%% Varargin
p = inputParser() ; 
addParameter(p,'PlotMe',false) ; 
addParameter(p,'PlotHere',true) ; 
addParameter(p,'tol',NaN) ; 
parse(p,varargin{:}) ; 
plotMeBool = p.Results.PlotMe ; 
plotHereBool = p.Results.PlotHere ; 
tol = p.Results.tol ; 

%% Calculation
gNext = guesses(end)-errors(end)*(guesses(end-1)-guesses(end))/(errors(end-1)-errors(end)) ; 

%% Plotting
if plotMeBool
    if plotHereBool
        secantPlot = findall(0,'Type','Figure','Name','fg_Secant') ; 
        if isempty(secantPlot)
            if exist('figGen','file') 
                secantPlot = figGen() ; 
            else 
                secantPlot = figure ; 
                axes ; hold all ; 
            end 
            xlabel("Guess (u)") ; ylabel("Error (u)") ; 
            yline(0,'Color','k','Alpha',1,'LineWidth',2,'HandleVisibility','off') ; 
            yline(tol,'Color','k','Alpha',1,'LineWidth',2,'LineStyle','--','HandleVisibility','off') ; 
            axis padded ; axis
            secantPlot.Name = "fg_Secant" ; 
        end
        secantAxes = secantPlot.Children(end) ; 
    else
        secantAxes = gca() ; 
    end
    ylim(secantAxes,max(abs(errors))*[-1,1]) ; 
    plot(secantAxes,guesses,errors,'Color','k','Marker','x','MarkerSize',8,'HandleVisibility','off') ; 
    plot(secantAxes,[guesses(end),gNext],[errors(end),0],'Color','k','LineStyle',':','HandleVisibility','off')
    plot(secantAxes,gNext,0,'Marker','o','Color','k','MarkerSize',8,'HandleVisibility','off') ; 
    xline(secantAxes,gNext,'Color','k','Alpha',1,'LineStyle',':','LineWidth',2,'HandleVisibility','off') ; 
    drawnow ; 
end

%% Output Handling
end