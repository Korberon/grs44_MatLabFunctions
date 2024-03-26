function colList = cmapGen(N) 
if nargin == 0 , N = 500 ; end 
O = 0 ; 

% colList = (cool(N+O)+summer(N+O))/2 ; 
cl1 = cool(N+O) ; cl2 = 1-summer(N+O) ; % cl2 = cl2(end:-1:1,:) ; 
colList = (cl1+cl2)/2 ; 
colList = colList(O+1:end,:) ; 
colList = colList(end:-1:1,:) ; 
clGrey = gray(1*N) ; 
% clGrey = clGrey(floor(length(colList)/2):end,:) ; 
clGrey = clGrey(1:size(colList,1),:) ; 
colList = colList.*(clGrey*0.9+0.34) ; 
colList = rgb2hsv(colList) ; 
colList(:,1) = colList(:,1)+0.2 ; 
% colList(:,3) = (colList(:,3)-0.5).*linspace(0,1,N)'+0.5 ; 
colList(:,2) = linspace(1,0.2,N).^0.7 ; 
colList(:,3) = linspace(0.02,1,N).^0.5 ; 
for i = 1 : size(colList,1) 
    if colList(i,1) > 1 , colList(i,1) = colList(i,1)-1 ; end 
    if colList(i,2) > 1 , colList(i,2) = colList(i,2)-1 ; end 
    if colList(i,3) > 1 , colList(i,3) = colList(i,3)-1 ; end 
end 
colList = hsv2rgb(colList) ; 