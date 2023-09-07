function [fg,ax] = figGen
    fg = figure ; fg.Position = [(2560-1200)/2,(1440-600)/2,1200,600] ;
    ax = axes ; ax.XLim = [0,1] ; ax.YLim = [0,1] ;
    ax.XLabel.Interpreter = "latex" ; ax.YLabel.Interpreter = "latex" ;
end