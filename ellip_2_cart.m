% Convert elliptic coordinates to carthersian cordinates
% phi,lambda in radians
% X,Y,Z,R,h in meters
% ellip is a struc as defined in main.m

function [X,Y,Z] = ellip_2_cart(phi,lambda,h,ellip)

    R = (ellip.a)/(sqrt(1-((ellip.e*sin(phi))^2)));

    X = (R + h)*cos(phi)*cos(lambda);
    Y = (R + h)*cos(phi)*sin(lambda);
    Z = (R*(1-(ellip.e^2)) + h)*sin(phi);

end