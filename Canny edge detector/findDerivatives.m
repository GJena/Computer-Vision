function [J, theta, Jx, Jy]=findDerivatives(I, Gx, Gy)

%declaring variables
delx=[1 -1];
dely=transpose(delx);

%smoothing image
G=conv2(Gx,Gy,'full');
Gdx=conv2(G,delx,'same');
Gdy=conv2(G,dely,'same');

%finding gradient direction and magnitude
Jx=conv2(I,Gdx,'valid');
Jy=conv2(I,Gdy,'valid');
J=sqrt(Jx.*Jx+Jy.*Jy); %magnitude of J
theta=atand(Jy./Jx); %direction

