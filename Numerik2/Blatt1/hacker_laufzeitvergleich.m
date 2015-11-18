function [] = hacker_laufzeitvergleich(laufweiten)

    warning off;            %Gebrabbel aus dem Hintergrund AUS.

    %Es wird f�r die im Vektor 'laufweiten' definierten ganzen Zahlen jeweils
    %eine Tridiagonalmatrix der entsprechenden Dimension n erstellt. Auf deren
    %Diagonalelementen stehen (von oberer Diagonalen zur unteren): -1,2,-1.
    %Die Initialisierung dieser wird nach dem Vorbild von 'tridiag.m'
    %vorgenommen.
        
    fprintf('Zuerst f�r volle Matrizen!\n')
for n = laufweiten;                  %Schleife �ber alle angegeben Laufweiten.
    
    A = zeros(n);                    %Initialisierung/Bereitstellung des Platzes der verwendeten Objekte (A,B,x,b).
    B = zeros(n);
    
    x = zeros(n,1);
    
    b = zeros(n,1);
    
    A = diag(ones(n-1,1),1);         %Diagonalmatrix A (Hauptdiagonale 1)
    
    B = 2.*eye(n)-A-A';              %B ist die benutzte Matrix mit -1,2,-1 auf den Diagonalen. eye(n) ist Eins-Element der nxn-Matrizen. A' ist das Transponierte von A, woraus die gew�nschte Form von B folgt
    
    b = 10.*rand(n,10);              %Zufallsvektor b der L�nge der Matrix-Dimension mit gr��tm�glichem Element 10
    
    tic;                             %Zeitmessung f�r die tats�chliche Rechnung des GLS beginnt.
    
    x = B\b;                         %L�sen des Gleichungssystems B*x=b.
    
    T = toc;                         %Zeitmessung stoppt und Variable T ist die gemessene Dauer.
    
    fprintf('Die Rechendauer f�r n=%d die Dimension des Systems betrug %.10f s\n', n, T);       %Ergebnisse auswerfen.
    
end

clear T;                             %Sicherheitshalber l�schen der Zeit/en.

    fprintf('Jetzt f�r schwach besetze Matrizen!\n')
for n = laufweiten;
    
    A = zeros(n);
    C = zeros(n);                    %Zus�tzliche Bereitstellung von Platz f�r die schwache besetzte Variante von B: C!
    B = zeros(n);
    
    x = zeros(n,1);
    
    b = zeros(n,1);
    
    A = diag(ones(n-1,1),1);
    
    B = 2.*eye(n)-A-A';
    
    b = 10.*rand(n,10);
    
    C = sparse(B);                   %C ist jetzt die 'gleiche' Matrix wie B, nur als sparse definiert!
    
    tic;
    
    x = C\b;
    
    T = toc;
    
    fprintf('Die Rechendauer f�r n=%d die Dimension des Systems betrug %.10f s\n', n, T);
    
end
    
    clear all;
    
end

