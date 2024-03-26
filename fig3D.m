function [fg,ax,lg,cb] = fig3D(varargin)
%% fig3D.m
% Generate a generic 3D figure to create consistent plots 
%% Optional Inputs:
%  'lg'       : Creates and displays the legend. This changes the way the axes fits in the figure
%  'FontSize' : Changes the relative font sizes for the figure (default 12)
%   - fontSize
%  'Title'    : Creates title and rearranges the axes
%  'Subtitle' : Creates subtitle and rearranges the axes
%  'ColorBar' : Creates a colorbar (default using hsv).
%   - N       : Number of colours in the colorbar
%  'cbType'   : Changes the default colorbar format
%   - cbType  : Equation to change the colorbar format to, eg. '1-cool'
%  'cbRev'    : Reverses the colorbar order
%% Outputs + Order:
%  'fg'       : Figure object
%  'ax'       : Axes object
%  'lg'       : Legend object
%  'cBar'     : Colorbar Object

%% Example Code: 
% To use fig3D(), here are some example codes: 
% [fg,ax] = fig3D() ; % Generic Set of Axes on a Figure 
% [fg,ax,lg] = fig3D('lg') ; % Generic + Empty Legend (use 'DisplayName' in plots / scatters) 
% [fg,ax] = fig3D('Title') ; % Generic + Title 
% [fg,ax,lg] = fig3D('Title','lg') ; % Generic + Empty Legend + Title 
% [fg,ax,cb] = fig3D('ColorBar',6) ; % Generic + Colourbar 
% [fg,ax,cb] = fig3D('ColorBar',6,'cbRev','cbType','1-cool') ; % Generic + More complicated colourbar, which has colours equal to 1-cool, in reverse order 
% [fg,ax,lg,cb] = fig3D('ColorBar',6,'lg') ; % Generic + Colourbar + Legend 

if and(max(contains(string(varargin),"lg")) == 1 ,max(contains(string(varargin),"ColorBar"))==1)
    [fg,ax,lg,cb] = figGen(varargin{1,:}) ; 
elseif max(contains(string(varargin),"lg")) == 1 , [fg,ax,lg] = figGen(varargin{1,:}) ; 
elseif max(contains(string(varargin),"ColorBar")) == 1 , [fg,ax,cb] = figGen(varargin{1,:}) ; 
elseif nargin > 0 , [fg,ax] = figGen(varargin{1,:}) ; 
else [fg,ax] = figGen() ; end 
view(45,(180*asin(1/sqrt(3)))/pi) ; 
if max(contains(string(varargin),"ColorBar")) == 0
    colList = cmapGen(100) ; colormap(colList) ; 
end 