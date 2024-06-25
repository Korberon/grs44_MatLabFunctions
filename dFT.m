function [Y,unitCircle,Yt2] = dFT(t, y, f) 
    %% dFT.m 
    % Simple Direct Fourier Transform Code to target specific frequencies around a given point 
    %% Example Code: 
    % tTest = 0 : 0.001 : 4 ; yTest = 2*sin(tTest*2*pi*3+pi/3) ; [YTest] = dFT(tTest,yTest,3) ; fg = figure ; fg.Position = [1920/2-1200/2,1080/2-600/2,1200,600] ; ax = axes ; hold all ; grid on ; grid('minor') ; ax.TickLabelInterpreter = 'latex' ; ax.FontSize = 12 ; xlabel("Time (s)",'Interpreter','Latex','FontSize',16) ; ylabel("Response (u)",'Interpreter','latex','FontSize',16) ; plot(tTest,yTest,'k-','LineWidth',2,'DisplayName','dFT Input') ; plot(tTest,abs(YTest)*cos(tTest*2*pi*3 + angle(YTest)),'r--','LineWidth',2,'DisplayName','dFT Output') ; legend('Interpreter','latex','Location','southoutside','orientation','Horizontal','FontSize',12) ; 
    %% How does it work? 
    % Uncomment the two lines in the for loop and add a breakpoint at the end of the function. Then copy and past the following into the console:
    % t = 0 : 0.0001 : 10 ; y = sin(t*2*pi*1)*2*pi*0.75 ; figGen ; plot(t,y) ; Y = dFT(t,y,1) ;
    % fg = figure ; hold all ; fg.Position(3) = fg.Position(4) ; axis equal ; xlim([-5,5]) ; ylim([-5,5]) ; for i = 2 : length(Yt1) , yt1 = plot(Yt1(2:i)) ; hold on ; yt2 = plot(Yt2(2:i),'r--') ; drawnow ; pause(0.001) ; delete(yt1) ; delete(yt2) ; end 
        
    %% Inputs: 
    %  t        : Time Data                                     (s) 
    %  y        : Input Data                                    (u) 
    %  Hz       : Target Frequency                              (Hz) 
    %% Outputs: 
    %  Y        : Fourier Transform of Y                        (U) 
    %             Positive phase from cosine 
    % Created by George Smith - grs44@bath.ac.uk 

    Y = 0 ; 
    unitCircle = zeros(size(y(1:end))) ; Yt2 = unitCircle ; 
    dt = mean(t(2:end)-t(1:end-1)) ; 
    for i = 2 : length(y) % for all sample points,
        unitCircle(i) = exp(-1j * 2 * pi * f * (i-1) * dt ) ; 
        Yt2(i) = y(i)*exp(-1j * 2 * pi * f * (i-1) * dt ) ; 
        Y = Y + y(i) * exp(-1j * 2 * pi * f * (i-1) * dt ) ; 
        % Y = sum of y(i)*complexCircle(f,i) 
    end 
    
    Y = Y / length(y) ; % Normalising 
end 