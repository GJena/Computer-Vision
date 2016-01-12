function [J, theta, Jx, Jy]=findDerivatives(I, Gx, Gy)
% Input: Image, 
% Output: Gradient direction, magnitude, 

% Declaring variables
delx=[1 -1];
dely=transpose(delx);

% Smoothing image
G=conv2(Gx,Gy,'full');
Gdx=conv2(G,delx,'same');
Gdy=conv2(G,dely,'same');

% Finding gradient direction and magnitude
Jx=conv2(I,Gdx,'valid');
Jy=conv2(I,Gdy,'valid');

% Magnitude
J=sqrt(Jx.*Jx+Jy.*Jy); 
% Direction
theta=atand(Jy./Jx); 

