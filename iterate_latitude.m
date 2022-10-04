function [phi,R_N] = iterate_latitude(X,Y,Z,ellip,seuil)
    % start with phi for an sphere
    phi = atan2(Z,sqrt((X^2)+(Y^2))); % phi(k), k = 0
    phik = Inf; % phi(k-1)

    while(abs(phi-phik)>=seuil)

        % calculate R_N(k) with phi(k)

        R_N = (ellip.a)/(sqrt(1-((ellip.e*sin(phi))^2)));

        % save phi(k) for comparison

        phik = phi;

        % calculate phi(k+1) with R_N(k) and phi(k)
        
        phi = atan2((Z + R_N*(ellip.e^2)*sin(phi)),sqrt((X^2)+(Y^2)));

    end

    % calculate final R_N
    R_N = (ellip.a)/(sqrt(1-((ellip.e*sin(phi))^2)));
end