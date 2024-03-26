function [ weightedTransform ] = dFT( t, y , Hz , varargin) 
%% dFT.m 
% Simple Direct Fourier Transform Code to target specific frequencies around a given point 
%% Example Code: 
% tTest = 0 : 0.001 : 4 ; yTest = 2*sin(tTest*2*pi*3+pi/3) ; fg = figure ; fg.Position = [1920/2-1200/2,1080/2-600/2,1200,600] ; ax = axes ; hold all ; grid on ; grid('minor') ; ax.TickLabelInterpreter = 'latex' ; ax.FontSize = 12 ; xlabel("Time (s)",'Interpreter','Latex','FontSize',16) ; ylabel("Response (u)",'Interpreter','latex','FontSize',16) ; plot(tTest,yTest,'k-','LineWidth',2,'DisplayName','dFT Output') ; [YTest] = dFT(tTest,yTest,3,'HzRange',0.1,'HzNo',2,'Weighted') ; plot(tTest,abs(YTest)*cos(tTest*2*pi*3 + angle(YTest)),'r--','LineWidth',2,'DisplayName','dFT Output') ; legend('Interpreter','latex','Location','southoutside','orientation','Horizontal','FontSize',12) ; 
%% Inputs: 
%  t        : Time Data                                     (s) 
%  y        : Input Data                                    (u) 
%  Hz       : Target Frequency                              (Hz) 
%% Optional Inputs: 
% HzRange   : Specific range of frequencies to analyse      (Hz-Hz) 
% HzNo      : Number of frequencies to analyse either side  (Int) 
% Weighted  : Sets weighting regime to Hann                 (None) 
%% Outputs: 
%  Y        : Fourier Transform of Y                        (U) 
%             Positive phase from cosine 
% Created by George Smith - grs44@bath.ac.uk 

%% Input Handling 
HzRange = 0.1 ; 
HzNo = 4 ; 
for i = 1 : length(varargin) 
    if string(varargin{i}) == "HzRange" , HzRange = varargin{i+1} ; i = i+1 ; end 
    if string(varargin{i}) == "HzNo" , HzNo = varargin{i+1} ; i = i+1 ; end 
end 
if max(contains(string(varargin),'Weighted')) == 1 
    weights = hann(HzNo*2+1) ; 
else 
    weights = ones(HzNo*2+1,1) ; 
end 

T = max(t) - min(t) ; % Time Period of Sample 
f0 = 1/T ; % Fundamental Frequency f_0

% Frequency range around the specified Hz 
Hzs = linspace(Hz-HzRange,Hz+HzRange,HzNo*2+1) ; 

% Initialize variables for weighted sum calculation 
weightedSum = 0 ; 

%% For all Frequencies of Interest, 
for Hzi = 1 : length(Hzs) , Hz = Hzs(Hzi) ; 
    % Frequency index 
    k = round(Hz / f0) ; 
    
    % Compute DFT at this frequency index 
    Transform = 0 ; 
    for n = 1:length(t) % At all harmonics,
        % Y = int(y(n)*e^(-2pi*f(n))) 
        Transform = Transform + y(n) * exp(-1j * 2 * pi * k * (n-1) / length(t)) ; 
    end 
    
    Transform = Transform / length(t) ; % Normalise from sample count

    weightedSum = weightedSum + Transform * weights(Hzi) ; % Weighted Fourier
end 

% Remove Non-Unit Weight 
weightedTransform = weightedSum / sum(weights) *2 ; 