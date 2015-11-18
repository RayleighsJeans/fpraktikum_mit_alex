function [] = hacker_blatt3aufgabe2(deltax);

%Hintergrund-Gemurmel aus.
warning off;

%Für alle delta-x aus dem Eingangs-Array.
for dx = deltax;
    
    %Für alle delta, die angegeben waren.
    for d = [0 0.25 0.5 1];
        
        %Für alle delta-t die angegeben waren.
        for dt = [0.001 0.005 0.01 0.1];

            %Intervalle abstecken.
            x=0:dx:2;
            t=0:dt:5;

            %Gebiet erstellen.
            [X,T] = meshgrid(x,t);
            
            %Gitterlängen bestimmen. Da der zentrale Differenzenquotient
            %vorkommt, wird das x-Intervall 'beschnitten'.
            a = length(x)-2;
            b = length(t);

            %Diagonal-Template.
            z = ones(a+2,1);
            
            %das b (später: rechte Seite) initiieren.
            r = zeros(a+2,1);

            %Nach Berechnung das b festgelegt.
            r(a+2,1) = 4*dx;

            %Matrix der rechten Seite erzeugen. Wirkt auf den k-ten
            %Zeitschritt (später).
            D = spdiags([(-2*(1-d)+(dx^2/dt))*z, (1-d)*z, (1-d)*z, ], [0, 1, -1], a+2, a+2);
            D(1,3) = -1+2*dx;
            D(a+2,a) = 1;

            %Matrix der linken Seite erstellen. Wirkt auf den
            %k+1-Zeitschritt.
            C = -spdiags([-d*(2+dx^2/dt)*z, d*z, d*z ], [0, 1, -1], a+2, a+2);

            %Anlegen der Lösung. In den Zeilen stehen die Werte am Ort, in
            %den Spalten findet die Zeitentwicklung statt.
            Y = zeros(b,a+2);
            Y(1,:) = 5;

            %Schleife für schrittweise Zeitentwicklung der Lösung von
            %k->k+1.
            for k=1:b-1;
                
                Y(k+1,1:end) = C\(D*Y(k,1:end)' + r);
                
            end;

            %Schreibe mit string-Konvertierungen für jede Kombination eine
            %*.mat-Datei zum Nachvollziehen.
            x_1 = num2str(d,'%g');
            x_2 = num2str(dt,'%g');
            x_3 = num2str(dx,'%g');

            fname = strcat('delta=',x_1,'dt=',x_2,'dx=',x_3);

            save(sprintf('Matrix_%s.mat',fname),'D','C','r','Y','X','T');

        end;
        
    end;
    
end;

clear all;

end

%Also ich finde meinen Fehler nach langem Suchen nicht... Die Werte der
%Lösung explodieren sofort in der Zeitentwicklung. Ich schätze, es wird ein
%Problem beim einsetzen/analysieren der Rand- und Anfangsbedingungen sein.
%Entweder ist die Implementierung falsch, oder die Rechnung auf dem Papier.
%Vielleicht fehlt ein Faktor oder eine ganze Komponente (aus dem vorherigen
%Zeitschritt, welche die Lösung klein hält.
%
%Die Idee ist, dass nur Werte von r<1/2 oder r=1/2 sinnvolle Ergebnisse
%liefern sollen (steifes System?!).

