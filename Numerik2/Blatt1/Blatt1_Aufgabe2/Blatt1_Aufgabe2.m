function Blatt1_Aufgabe2
    
    tests = [10, 100, 1000, 10000, 100000, 1000000]; % Testfälle
    fprintf('Mit Schleifennotation:\n');
    for n = tests
        % Zeitmessung Start
        tic; 
        
        % Speicherplatz reservieren
        %v = zeros(n,1);
        %w = v;
        
        % Ersten Vektor füllen
        for k=1:n
            v(k) = k^2;
        end
        
        % Zweiten Vektor füllen
        w(1) = 0;
        for k=2:n-1
            w(k) = v(k+1) - v(k-1);
        end
        w(n) = 0;
        
        % Zeitmessung + Ausgabe
        zeit = toc;
        fprintf('Zeit für n = %d: %f\n', n, zeit);
        
        % Vektoren löschen
        clear v w;
    end
    fprintf('\nMit Vektornotation:\n');
    for n = tests
        % Zeitmessung Start
        tic;
        % Ersten Vektor füllen
        v2 = (1:n).^2;
        % Zweiten Vektor füllen
        w2 = [0, v2(3:n) - v2(1:n-2), 0];
        % Zeitmessung + Ausgabe
        zeit = toc;
        fprintf('Zeit für n = %d: %f\n', n, zeit);
        % Vektoren löschen
        clear v2 w2
    end
end

