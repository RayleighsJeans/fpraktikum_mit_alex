function [] = hacker_blatt5aufgabe2u1(a,b,max_ma,max_mb);

%Mache die exakte Lösung auf einem feinen, eindimensionalen Gitter auf dem
%Intervall (1,4).

x = 1:0.001:4;
act_sol = zeros(1,length(x));
act_sol = x-2*log(x);

%Hintergrundgemurmel aus.

warning off;

%Fange jetzt an, die beiden Varianten (aus der Übung und Hausaufgabe) zu
%programmieren. Als erstes die Version der Übung mit k=2...m.

%%Ab k=2!

%Beginne mit der kleinsmöglichen Lösung (siehe später: Abbruchbedingungen).

m=2;

%So lange wie kein break erfolgt, geht die while-Schleife weiter.

while true
    
        %Mache Matrizen/Vektoren.
    
        b_2 = zeros(m,1);
        K_2 = zeros(m,m);
        C_2 = zeros(m,1);
        
        %Zwei verschachtelte Schleifen für die Definitionen.

        for i=2:m;
            for k=2:m;

                %Ohne Ausnahmen können b_j und K_jk über die Potenzen
                %definiert werden. Es müssen in der Integration keine
                %Besonderheiten (k=1 o.ä.) beachtet werden.
                
                b_2(i) = (4^(i)-1)/i-log(4)-1/4*(4^(i)-1);

                K_2(k,i) = -k*i/(k+i-1)*(4^(k+i-1)-1)+k/(k+i-1)*(4^(k+i-1)-1)-k/(k-1)*(4^(k-1)-1);

            end;
        end;
        
    %Lösen den LGS mit den richtigen Indizees der Matrizen. Sozusagen:
    %ausklammern der 1. Zeile und Spalte in K, 1. Element in B und C.
        
    C_2(2:end) = K_2(2:end,2:end)\b_2(2:end);
    
    %Rekombination der Lösungen c_k. Dafür zwei Matrizen genötigt.
    
    pre_sol_2 = zeros(m-1,length(x));
    sol_2 = zeros(1,length(x));
    
    for j=1:length(x);
        for k=2:m;
        
        %Schreibe für jedes k(Anteil der Summe über k)den Wert von
        %c_k*(x^k-1) mit dem jeweiligen x-Wert vom Gitter in eine Matrix.
        %Das soll die Pre-Solution sein.
            
        pre_sol_2(k-1,j) = C_2(k).*(x(j).^(k)-1);
        
        end;
        
        %Die richtige Lösung entsprich letztlich 1+der Summe über alle
        %k-Elemente für einen x-Wert.
        
        sol_2(j) = 1+sum(pre_sol_2(:,j));
        
    end;

    %Abbruchbedingungen: einmal für eine gewisse Genauigkeit a (aus
    %Eingabevektor) und einmal für ein maximales m (Anzahl der Elemente in
    %der Summe, e.g. beschränkt die Rechenzeit von oben).
    
    if max(abs(sol_2(:)-act_sol(:)))<a

        break
        
    elseif m>max_ma
        
        break

    end;

    %Falls Bedingungen nicht erfüllt, mache die ganze Geschichte um einen
    %größer und fang nochmal von vorne an
    
    m = m+1;
    
    clear j i k C_2 b_2 K_2 pre_sol_2 sol_2;
    
end

    clear j m i k ;
    
%Jetzt die ganze Sache nur nochmal für eine Summe von k=1...m machen!
%Gleiches Spiel wie vorher, nur mit Beachtung der veränderten
%Integrale(Faktoren von c_k).
    
%%Ab k=1!

m=3;

while true
    
    b_1 = zeros(m,1);
    K_1 = zeros(m,m);
    C_1 = zeros(m,1);

    for i=1:m;
        
        %Für alle i muss K_i1 anders aussehen (ein Logarithmus unabhängig
        %von i).
        
        K_1(1,i) = -4.^(i)-1+1/i*(4.^(i)-1)-2*log(2);
        
        for k=2:m;
            
            b_1(i) = (4^(i)-1)/i-log(4)-1/4*(4^(i)-1);
            
            K_1(k,i) = -k*i/(k+i-1)*(4^(k+i-1)-1)+k/(k+i-1)*(4^(k+i-1)-1)-k/(k-1)*(4^(k-1)-1);
            
        end;
    end;

%Hier die Ganzen Ausnahmen mit hinein geschrieben, welche sonst falsch
%berechnet werden über die Potenzen in den Schleifen von i,k.
    
b_1(1) = 3-2*log(2)-1/4*(4-1);
K_1(1,1) = -2*log(2);
K_1(2,1) = -(15/2+2*log(2));
K_1(1,2) = 12;
K_1(2,2) = -16;

%Gleiches Verfahren wie vorhin.

C_1 = K_1\b_1;

    pre_sol_1 = zeros(m,length(x));
    sol_1 = zeros(1,length(x));
    
    for j=1:length(x);
        for k=2:m;
        
        pre_sol_1(k-1,j) = C_1(k).*(x(j).^(k)-1);
        
        end;
        
        sol_1(j) = 1+sum(pre_sol_1(:,j));
        
    end;

    if max(abs(sol_1(:)-act_sol(:)))<b

        break
        
    elseif m>max_mb
        
        break

    end;

    m = m+1;
    
end

    clear j m i k;

%Schmeiße die Daten und ein Bild für den Plot aus. Wird gespeichert.
    
save('hacker_blat5_daten.mat','sol_1','sol_2','x','K_1','K_2','C_2','C_1','b_2','b_1','act_sol','a','b','max_ma','max_mb');

figure;
hold on;
plot(x,act_sol,x,sol_1,x,sol_2);
legend('ex. Lösung','Lösung ab k=1','Lösung ab k=2');
xlabel('x');
ylabel('Funktionswerte');
savefig('hacker_blatt4vergleich.fig');
string = sprintf('Genauigkeit (k=1) %g\n Genauigkeit (k=2) %g\n max. m (k=1) %i\n max. m (k=2) %i\n',b,a,max_mb,max_ma);
annotation('textbox',[0.15 0.27 0.1 0.1],'String',string,'FitBoxToText','on');
hold off;

%Eigenartiger Weise speichert die .fig-Datei nicht die Annotation im Bild.
%Ich hänge aber das Bild mit m=5 als .png mit aus.

%Leider sehe ich die gewünschte KOnvergenz nicht. Es ist nicht so, als
%hätte ich ein unglaublich hohes m angestrebt, aber mit m<20 etwa ändert
%sich mit meinem Code gar nichts mehr. Trotzdem war die Aufgabe,
%Koeffizienten wieder zum Graphen auf einem Intervall zusammen zu fügen und die
%Erinnerung an Fehler-orientierte Schleifen eine nette Übung.

end
    