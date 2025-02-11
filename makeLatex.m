function ax = makeLatex(ax)
%% makeLatex.m
%   Function to correct any set of axes to the appropriate LaTeX format and outlines
%% Inputs: 
%   ax    : Set of axes to correct
%% Outputs: 
%   ax    : Corrected set of axes
%
%% Created by George R. Smith - grs44@bath.ac.uk 

fontSize = 15 ; 
hold all ; ax.LineWidth = 2 ; grid on ; grid('minor') ;  if version('-release') == "2023b" , ax.GridLineWidth = 1 ; end
ax.XAxis.FontSize = fontSize ; ax.YAxis(1).FontSize = fontSize ; ax.ZAxis.FontSize = fontSize ; ax.TickLabelInterpreter = 'latex' ; 
if size(ax.YAxis,1) > 1 , ax.YAxis(2).FontSize = fontSize ; end 
xlabel('x','interpreter','latex','FontSize',fontSize+2) ; ylabel('y','interpreter','latex','FontSize',fontSize+2) ; zlabel('z','interpreter','latex','FontSize',fontSize+2) ; 
colororder('k') ; ax.Box = 'on' ; 
lg = gca().Legend ; 
if size(lg,1) ~= 0 , lg.Interpreter = 'latex' ; lg.FontSize = fontSize ; end 