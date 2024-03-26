function [ddy] = centralDifference2(xD,y,index) 
ddy = zeros(size(y)) ; 

if index == 1 
    for i = 2 : size(y,index)-1 
        ddy(i,:) = (y(i+1,:)-2*y(i,:)+y(i-1,:))/(xD(i)*xD(i-1)) ; 
    end 
elseif index == 2 
    for i = 2 : size(y,index)-1 
        ddy(:,i) = (y(:,i+1)-2*y(:,i)+y(:,i-1))/(xD(i)*xD(i-1)) ; 
    end 
end 