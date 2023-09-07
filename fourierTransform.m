function [f,X,f_interest] = fourierTransform(t,x,~)
    X = fft(x) ;
    X = fftshift(X) ;
    % Calculate the sampling rate
    dt = t(2) - t(1);
    fs = 1 / dt;
    
    % Generate frequency axis
    N = length(x);
    f = (-N/2:N/2-1) * fs / N;

    if nargin > 2
        [~,ax] = figGen() ;
        plot(ax,f(floor(N/2):end),X(floor(N/2):end))
        ax.XLabel.String = "Frequency (Hz)" ; ax.YLabel.String = "Fourier Transform" ;
        ax.XLim = [f(floor(N/2)),f(end)] ; ax.YLim = [min(abs(X)),max(abs(X))] ;
    end
    counter_interest = 1 ;
    for i = floor(length(f)/2)+1 : length(f)
        if and( f(i)>0 , i<N )
            if abs(X(i)) > 10*std(X)
                if and(abs(X(i)) > abs(X(i-1)) , abs(X(i)) > abs(X(i+1)))
                    f_interest(counter_interest) = f(i) ;
                    counter_interest = counter_interest + 1 ;
                end
            end
        end
    end
end