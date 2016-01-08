function [g,w] = gPunkt2D
    % Verbesserte Formel für Referenzdreieck
    g(1,:) = [1/2 0];
    g(2,:) = [1/2 1/2];
    g(3,:) = [0 1/2];
    w(1) = 1/6;
    w(2) = 1/6;
    w(3) = 1/6;
end