function yEnd = Blatt3_Aufgabe2c(h)
   
    % Gitter in x-Richtung
    x = 0:h:4;
    n_x = length(x)-2;
    
    % Endzeit
    TEnd = 1;
    
    % Matrix erstellen
    e = ones(n_x,1);
    A = spdiags([e, -2*e, e], [-1 0 1], n_x, n_x);
    
    % Vorwärts-DQ
    A(n_x,n_x) = -1;
        
    % Anfangswerte
    y0 = (x(2:n_x+1)-4).^2;
    
    % rechte Seite ODE
    function f = rhs(t,y)
        f = (1/h^2)*(A*y + [15*exp(-t^2)+1; zeros(n_x-1,1)]);
    end
        
    % ode45 (explizites Verfahren) aufrufen
    fprintf('ode45:\n');
    options = odeset('Stats','on');
    tic;
    [T, Y2] = ode45(@rhs, [0, TEnd], y0, options);
    t_ode45 = toc;
    fprintf('Dauer: %f\n', t_ode45);
    
    % ode23s (implizites Verfahren) aufrufen
    fprintf('\node23s:\n');
    options = odeset('Stats','on');
    tic;
    [T, Y2] = ode23s(@rhs, [0, TEnd], y0, options);
    t_ode23s = toc;
    fprintf('Dauer: %f\n', t_ode23s);
        
    % Randwerte setzen
    Y = [15*exp(-T.^2)+1, Y2, Y2(:,end)];
    
    % Lösung plotten
    figure;
    for i = 1:length(T)-1
        plot(x, Y(i,:));
        axis([0 4 0 18]);
        title(sprintf('t = %f', T(i)));
        drawnow;
        pause(0.5*(T(i+1)-T(i)));
    end
    plot(x, Y(end,:));
    axis([0 4 0 18]);
    title(sprintf('t = %f', T(end)));
    
    yEnd = Y(end,:);
end
