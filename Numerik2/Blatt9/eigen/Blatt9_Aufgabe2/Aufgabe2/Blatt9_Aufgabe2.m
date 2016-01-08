% Blatt9_Aufgabe2(0.1, 1e-6, 1000);
% Blatt9_Aufgabe2(0.01, 1e-6, 100000);
function Blatt9_Aufgabe2(h, tol, maxIt)
    
    % Gitter erzeugen
    x = 0:h:1;
    y = 0:h:1;
    [X,Y] = meshgrid(x,y);
        
    n_x = length(x)-2;
    n_y = length(y)-2;
    
    [A,b] = Differenzen_Bsp1(h);
    
    % Lösung erstellen
    % Randbedingungen einsetzen
    u = zeros(n_x+2,n_y+2);
    
    x0 = -100*ones(n_x^2,1);
    tic;
    [~, res_jac, iter_jac] = jacobi(A,b,x0,tol,maxIt);
    t_jac = toc;
    tic;
    [~, res_gauss, iter_gauss] = gauss(A,b,x0,tol,maxIt);
    t_gauss = toc;
    tic;
    [u_cg, res_cg, iter_cg] = cg(A,b,x0,tol,maxIt);
    t_cg = toc;
    
    u(2:n_y+1, 2:n_x+1) = reshape(u_cg, n_x, n_y)';
    
    figure;
    surf(X,Y,u, 'EdgeColor', 'none'); 
    
    figure;
    loglog(1:maxIt+1, [res_jac; res_gauss; res_cg]);
    legend('Jacobi', 'Gauss-Seidel', 'cg');
    
    fprintf('Zeit Jacobi: %f\n', t_jac);
    fprintf('Anzahl Iterationen Jacobi: %d\n', iter_jac);
    fprintf('Zeit Gauss: %f\n', t_gauss);
    fprintf('Anzahl Iterationen Gauss: %d\n', iter_gauss);
    fprintf('Zeit cg: %f\n', t_cg);
    fprintf('Anzahl Iterationen cg: %d\n', iter_cg);
end