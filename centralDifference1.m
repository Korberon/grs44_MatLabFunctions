function [dy] = centralDifference1(xD,y,index) 
dy = zeros(size(y)) ; 

if index == 1 
    for i = 2 : size(y,index)-1 
        dy(i,:) = (y(i+1,:)-y(i-1,:))/(xD(i)+xD(i-1)) ; 
    end 
elseif index == 2 
    for i = 2 : size(y,index)-1 
        dy(:,i) = (y(:,i+1)-y(:,i-1))/(xD(i)+xD(i-1)) ; 
    end 
end 