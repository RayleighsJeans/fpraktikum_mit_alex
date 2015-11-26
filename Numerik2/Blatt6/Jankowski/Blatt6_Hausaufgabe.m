function Blatt6_Hausaufgabe(m,p) % m: Anzahl der Elemente, p: Grad des Polynoms (1 oder 2)
   
if(p==1)
    % m Elemente -> m+1 Knoten
    x = linspace(-2, 2.5, m+1);

    % Zuordnung Elemente -> Knoten
    elemKnot = [(1:m)', (2:m+1)'];

    % Speicherplatz Steifigkeitsmatrix
    K = sparse(m+1,m+1);

    % Speicherplatz für Lastvektor
    f = zeros(m+1,1);

    % Elementweiser Aufbau
    for k=1:m
        % Element-Knoten
        Knoten = elemKnot(k,:);

        % Element-Steifigkeit und Lastvektor
        [K_e,f_e] = ElemLS(p,Knoten,x);

        % Einfügen in Steifigkeitsmatrix
        K(Knoten,Knoten) = K(Knoten,Knoten) + K_e;

        % Einfügen in Lastvektor
        f(Knoten) =  f(Knoten) + f_e;
    end
    elseif(p==2)
        
        %Für quadratische Formfunktionen brauchen wir 2*m+1 Knoten anstatt m+1
        
        % m Elemente -> 2*m+1 Knoten
        x = linspace(-2, 2.5, 2*m+1);
           
        % Zuordnung Elemente -> Knoten
        elemKnot = [(1:2:2*m-1)', (2:2:2*m)', (3:2:2*m+1)'];
        
        % Speicherplatz Steifigkeitsmatrix
        K = sparse(2*m+1,2*m+1);
        
        % Speicherplatz für Lastvektor
        f = zeros(2*m+1,1);
        
        % Elementweiser Aufbau
        for k=1:m
            % Element-Knoten
            Knoten = elemKnot(k,:);
           
            % Element-Steifigkeit und Lastvektor
            [K_e,f_e] = ElemLS(p,Knoten,x);
           
            % Einfügen in Steifigkeitsmatrix
            K(Knoten,Knoten) = K(Knoten,Knoten) + K_e;
                    
            % Einfügen in Lastvektor
            f(Knoten) =  f(Knoten) + f_e;
        end
    else 
      fprintf('Inkorekte Eingabe des 2. Parameters; nur Polynome 1. oder 2. Grades moeglich!\n');
    return
    end
     
    
    % Randbedingung Dirichlet
    
    % Straftechnik
    K(1,1) = K(1,1) + 1e8;
    f(1) = f(1) + 14.8*1e8;
    
    % Zeile ersetzen
    % K(1,:) = 0; K(1,1) = 1; f(1) = 1;
    
    % Randbedingung Neumann
    if(p==1)
    f(m+1) = f(m+1)-23;
    else
    f(2*m+1) = f(2*m+1)-23;
    end
    % LGS Lösen
    u = K\f;
    
    % Lösung plotten
    plot(x,u);
    
    % mit exakter Lösung vergleichen
    ex = (((x.^2)+2)./(x-3))+4*(x.^2);
    hold on;
    plot(x,ex,'r*');
    fprintf('Maximale Abweichung an den Knotenpunkten: %f\n', max(abs(u-ex')));
end
    

