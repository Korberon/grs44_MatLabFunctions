function [an] = annoTable(fg,ax,N,M,loc,scale,manual)
%% annotable.m 
% Function to create annotation tables (similar to a legend) 
%% Inputs  : 
% fg       : Figure object 
% ax       : Axes object 
% N        : Number of rows 
% M        : Number of columns 
% Loc      : Location of annotation [ horizontal fraction , vertical fraction ] of axes 
% varargin : [width,height] of cell (relative to horizontal axis dimension) 
%% Outputs : 
% an       : Annotation object 
    % an(i,j).a || Colour box of row i , column j 
    % an(i,j).b || Text box of row i , column j 
%% Example Code : 
% [fg,ax] = figGen ; an = annoTable(fg,ax,2,1,[1,1]) ; % Generic annotation table in the top right with default colours, in a 2x1 grid. Use an() as in 'Outputs : ' above
% [fg,ax] = figGen ; an = annoTable(fg,ax,2,1,[1,1],[0.12,0.08]) ; % Generic annotation table, which is 0.12 wide, 0.08 tall
% [fg,ax] = figGen ; an = annoTable(fg,ax,2,1,[1,1],[0.12,0.08],0.06) ; % Generic annotation table, where an().a is 0.06x0.08, an().b is 0.12x0.08

if nargin > 5 
    width2 = scale(1) ; 
    width1 = scale(2) ; 
else
    width1 = 0.025 ; width2 = 0.065 ; 
end

axPos = ax.Position ; 

axAbs = ax.Position .* [fg.Position(3),fg.Position(4),fg.Position(3),fg.Position(4)] ; 
if nargin > 6 
    height = manual ; 
else 
    height = width1*axAbs(3)/axAbs(4) ; 
end 

posL(1) = axPos(1)-width1-width2 ; posL(2) = axPos(2)-height ; 
posL(3) = width1 ; posL(4) = height ; posL = posL-[0,0,0,0]+[loc,0,0].*[axPos([3,4]),0,0] ; 
posR = [posL(1)+width1,posL(2),width2,posL(4)] ; 

for i = 1 : N 
    iOffset = [0,height*(i-1),0,0] ; 
    for j = 1 : M 
        jOffset = [(width1+width2)*(M-j),0,0,0] ; 
        an(i,j).a = annotation('textbox','Position',posL-iOffset-jOffset,'HorizontalAlignment','center','VerticalAlignment','middle','LineWidth',ax.LineWidth) ; 
        an(i,j).b = annotation('textbox','Position',posR-iOffset-jOffset,'HorizontalAlignment','left','VerticalAlignment','middle','LineWidth',ax.LineWidth) ; 
    end 
end 
colList = cmapGen(N*M) ; 
counter = 0 ; 
for i = 1 : N 
    for j = 1 : M 
        counter = counter + 1 ; 
        an(i,j).a.BackgroundColor = colList(counter,:) ; 
        an(i,j).b.BackgroundColor = 'w' ; 
        an(i,j).b.String = string(i)+" , "+string(j) ; 
        an(i,j).a.Interpreter = 'latex' ; 
        an(i,j).b.Interpreter = 'latex' ; 
        an(i,j).a.FontSize = ax.XAxis.FontSize-2 ; 
        an(i,j).b.FontSize = ax.XAxis.FontSize-2 ; 
    end 
end 


end 