function [dy] = centralDifference1(xD,y,index) 
dy = zeros(size(y)) ; 
if length(xD) == 1 , xD = xD*ones(size(y)) ; end 

if index == 1 
    for i = 2 : size(y,index)-1 
        dy(i,:) = (y(i+1,:)-y(i-1,:))/(xD(i)+xD(i-1)) ; 
    end 
    dy(1,:) = (y(2,:)-y(1,:))/(xD(2)+xD(1)) ; 
    dy(end,:) = (y(end,:)-y(end-1,:))/(xD(end)+xD(end-1)) ; 
elseif index == 2 
    for i = 2 : size(y,index)-1 
        dy(:,i) = (y(:,i+1)-y(:,i-1))/(xD(i)+xD(i-1)) ; 
    end 
    dy(:,1) = (y(:,2)-y(:,1))/(xD(2)+xD(1)) ; 
    dy(:,end) = (y(:,end)-y(:,end-1))/(xD(end)+xD(end-1)) ; 
end 