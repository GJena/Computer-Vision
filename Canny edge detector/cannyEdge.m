function E = cannyEdge(I)
%% Canny edge detector
%  Input: A color image I = uint8(X, Y, 3), where X, Y are two dimensions
%  of the image
%  Output: An edge map E = logical(X, Y)

%% Convert the color image to gray scale image
%  Output I = uint8(X, Y)

dim=size(I);
% Converting the colour image I to gray scale image
I=uint8(I); 

if size(dim,2)==3
    I = rgb2gray(I);
end

% Adjusting the contrast of the image
I=imadjust(I);

imshow(I);

%% Construct 2D Gaussian filter
Gx = normpdf([-5:1:5], 0, 1.3);
Gy = normpdf([-5:1:5], 0, 1.3)';

%% Computing the magnitutde and orientation of derivatives
%  J = double(X, Y), the magnitude of derivatives
%  theta = double(X, Y), the orientation of derivatives
%  Jx = double(X, Y), the magnitude of derivatives along x-axis
%  Jy = double(X, Y), the magnitude of derivatives along y-axis

% Mirror padding the image
Ipad=padarray(I,[5 5],'symmetric','both');

[J, theta, Jx, Jy] = findDerivatives(Ipad, Gx, Gy);
visDerivatives(I, J, Jx, Jy);

% Eliminating nan values
theta(isnan(theta))=0;

% Adding 180 degrees to negative angles
theta(theta<0)=theta(theta<0)+180;

% Detecting local maximum
%  M = logical(X, Y), the edge map after non-maximal suppression
M = nonMaxSup(J, theta);
figure; imagesc(M); colormap(gray);

% Linking edges
%  E = logical(X, Y), the final edge map
E = edgeLink(M, J, theta);
figure; imagesc(E); colormap(gray);
% 
