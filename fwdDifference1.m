function [dy] = fwdDifference1(xD,y,index) 
dy = zeros(size(y)) ; 
if length(xD) == 1 , xD = xD*ones(size(y)) ; end 

if index == 1 
    for i = 2 : size(y,index)-1 
        dy(i,:) = (y(i+1,:)-y(i,:))/xD(i) ; 
    end 
elseif index == 2 
    for i = 2 : size(y,index)-1 
        dy(:,i) = (y(:,i+1)-y(:,i))/xD(i) ; 
    end 
end 