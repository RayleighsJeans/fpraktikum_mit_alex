function [g,w] = gPunkt2D
    % Schwerpunktformel für Referenzdreieck
    g(1,1) = 1/2;
    g(1,2) = 0;
    g(2,1) = 0;
    g(2,2) = 1/2;
    g(3,1) = 1/2;
    g(3,2) = 1/2;
    w(1) = 1/6;
end