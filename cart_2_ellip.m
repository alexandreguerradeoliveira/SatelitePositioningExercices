% Convert carthesian coordinates to elliptic cordinates
% phi,lambda in radians
% X,Y,Z,R,h in meters
% ellip is a struc as defined in main.m 
% % (seuil = 10^(-2)/3600 ??)

function [phi,lambda,h] = cart_2_ellip(X,Y,Z,ellip,seuil)
    lambda = atan2(Y,X);

   %solve iteration to get phi and R_N
   [phi,R_N] = iterate_latitude(X,Y,Z,ellip,seuil);

   h = (sqrt((X^2)+(Y^2))/cos(phi)) - R_N;

end


