function [ddy] = centralDifference2(xD,y,index) 
ddy = zeros(size(y)) ; 
if length(xD) == 1 , xD = xD*ones(size(y)) ; end 

if index == 1 
    for i = 2 : size(y,index)-1 
        ddy(i,:) = (y(i+1,:)-2*y(i,:)+y(i-1,:))/(xD(i)*xD(i-1)) ; 
    end 
    ddy(1,:) = ( (y(3,:)-y(2,:))/xD(2) - (y(2,:)-y(1,:))/xD(1) ) / (xD(2) + xD(1))*2 ; 
    ddy(end,:) = ( (y(end,:)-y(end-1,:))/xD(end) - (y(end-1,:)-y(end-2,:))/xD(end-1) ) / (xD(end) + xD(end-1))*2 ; 

    ddy(1,:) = mean(ddy(1:3,:)) ; 
    ddy(end,:) = mean(ddy(end-2:end,:)) ; 
elseif index == 2 
    for i = 2 : size(y,index)-1 
        ddy(:,i) = (y(:,i+1)-2*y(:,i)+y(:,i-1))/(xD(i)*xD(i-1)) ; 
    end 
    ddy(:,1) = ( (y(:,3)-y(:,2))/xD(2) - (y(:,2)-y(:,1))/xD(1) ) / (xD(2) + xD(1))*2 ; 
    ddy(:,end) = ( (y(:,end)-y(:,end-1))/xD(end) - (y(:,end-1)-y(:,end-2))/xD(end-1) ) / (xD(end) + xD(end-1))*2 ; 

    ddy(:,1) = mean(ddy(:,1:3)')' ; 
    ddy(:,end) = mean(ddy(:,end-2:end)')' ; 
end 