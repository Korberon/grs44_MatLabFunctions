function an = annoTableRaw(ax,position)
%% annoTableRaw.m
%   Creates an Annotation Table (see annoTable.m), but does it in a very low-level way
%% Inputs       :
%   ax          : Axes object
%   position    : Position
%% Outputs      :
%   an          : Annotation table object
%
%% Created by George R. Smith - grs44@bath.ac.uk 

ax.Units = 'pixels' ; 
an = annotation('textbox','Units','pixels','Position',position.*ax.Position) ; 