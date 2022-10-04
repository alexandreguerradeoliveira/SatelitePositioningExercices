function [X, Y] = proj_CH1903p_2_MN95(phi, lambda, ellip)

    % Projection des coordonnées géographiques ellipsoïdiques CH1903+ (φ (B), λ (L), h) dans le système
    % cartographique Suisse MN95 (Est (Y), Nord (X)) à l'aide des formules rigoureuses (chap 3.2 et 3.3 de
    % swisstopo)
    % Input : ellip.a | ellip.E | phi0 | lambda0

    %% Constantes
    phi0 = deg2rad(dms2degrees([46 57 8.66] )); % 46° 57' 08.66"
    lambda0 = deg2rad(dms2degrees([7 26 22.5] )); % 7° 26' 22.50"

    %% Grandeurs auxiliaires
    % Rayon de la sphere de projection
    R = ellip.a * sqrt(1 - ellip.E^2) / ( 1 - (ellip.E * sin(phi0))^2 );
    % Rapport des longitudes (de la sphere à l'ellipsoide)
    alpha = sqrt( 1 + ellip.E^2 / ( 1- ellip.E^2 ) * cos(phi0)^4 );
    % Latitude de l'origine sur la sphere
    b0 = asin( sin(phi0) / alpha );
    % Constante de la formule des latitudes
    K = log( tan(pi/4 + b0/2) ) - alpha * log( tan(pi/4 + phi0/2) ) + 0.5 * alpha * ellip.E * log( ( 1 + ellip.E + sin(phi0) ) / ( 1 - ellip.E * sin(phi0) ) ) ;

    
    
    %% Projection de Gauss - Ellipsoide to sphere
    
    %Valeur auxiliaire
    S = alpha * log( tan( pi/4 + phi/2 ) ) - 0.5 * alpha * ellip.E * log( ( 1 + ellip.E + sin(phi) ) / ( 1 - ellip.E * sin(phi) ) ) + K;
    %Latitude Spherique
    b = 2 * ( atan(exp(S)) - pi/4);
    %Longitude Spherique
    l = alpha * (lambda - lambda0);

    %% Systeme equatorial -> systeme pseudo-equatorial

    l_bar = atan2( sin(l), sin(b0) * tan(b) + cos(b0) * cos(l) );
    b_bar = asin( cos(b0) * sin(b) - sin(b0) * cos(l) );

    %% Sphere-> plan de projection (Mercator)
    
    Y = R * l_bar;

    X = 0.5*R * log( (1 + sin(b_bar))/(1 - sin(b_bar)) );











end