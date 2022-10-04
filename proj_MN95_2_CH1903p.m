function [phi, lambda] = proj_MN95_2_CH1903p(X_MN95, Y_MN95, ellip, seuil)
    % Coordonnées géographiques ellipsoïdiques CH1903+ (φ (B), λ (L), h) à
    % partir du système projeté cartographique Suisse MN95 (Est (Y), Nord (X))
    % à l'aide des formules rigoureuses (chap 3.2 et 3.3 de swisstopo)
    % Input : X,Y (MN95) | ellip | seuil
    % Output : phi | lambda

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

    %% Plan de projection -> Sphere
    Y = Y_MN95 - 2600000; %m
    X = X_MN95 - 1200000; %m

    l_bar = Y/R;
    b_bar = 2 * ( atan(exp(X/R)) - pi/4 );

    %% Systeme pseudo-equatorial -> systeme equatorial

    b = asin(cos(b0) * sin(b_bar) + sin(b0) * cos(b_bar) * cos(l_bar) );
    l = atan2(sin(l_bar), cos(b0) + cos(l_bar) - sin(b0) * tan(b_bar));

    %% Sphere -> ellipsoide
    lambda = lambda0 + l/alpha;

    %Initialize
    phi = b;
    phi_old = Inf;
    %Iterate
    while abs(phi-phi_old)>=seuil
        S = (1/alpha) * ( log(tan(pi/4 + b/2)) - K ) + ellip.E * log( tan(pi/4 + 0.5*sin(ellip.E * sin(phi))) );
        phi = 2 * atan(exp(S)) - pi/2;
        phi_old = phi;
    end % Stop when phi close enough


end