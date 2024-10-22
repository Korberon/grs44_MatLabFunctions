fileName = 'Drop Test Graph' ; 

img = imread(fileName+".jpg") ; 
image(img) ; 
title("Click left button to set data points, right button to end")
% You can adapt the following code to enter data interactively or automatically.

x = [] ; 
y = [] ; 

hold on 
% Firstly, get origin location. You'll also need another reference point 
% for scaling. 
[xOrigin, yOrigin, button] = ginput(1) ; 
plot(xOrigin, yOrigin, '+b') % '+b' means plot a blue cross.

while 1 % infinite loop
    [x, y, button] = ginput(1); % get one point using mouse
    if button ~= 1 % break if anything except the left mouse button is pressed
        break
    end
    plot(x, y, 'og') % 'og' means plot a green circle.
    
    % Add data point to vectors. Note that x and y are pixel coordinates.
    % You need to locate the pixel coordinates of the axes, interactively
    % or otherwise, and scale the values into time (s) and temperature (F, C or K).
    x = [x, x];
    y = [y, y];
end
hold off

%save data to .mat file with same name as image file
save(fileName, 'x', 'y')

