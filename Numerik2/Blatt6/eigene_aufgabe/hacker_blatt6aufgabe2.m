function hacker_blatt6aufgabe2 % m: Anzahl der Elemente, p: Polynom-Grad

%%Machen 2 Schleifen f�r p=1,2 und die verschiedenen m's. F�ge noch 128,256
%%hinzu, weil es die kurze Rechenzeit hergibt.

    for p = [1,2]
        for m = [4,8,16,32,64,128,256]

            %%Fallunterscheidung f�r p=1 ab hier.
            
            if (p==1)

                %% m Elemente -> m+1 Knoten
                x = linspace(-2, 2.5, m+1);

                %% Zuordnung Elemente -> Knoten
                elemKnot = [(1:m)', (2:m+1)'];

                %% Speicherplatz Steifigkeitsmatrix
                K = sparse(m+1,m+1);

                %% Speicherplatz f�r Lastvektor
                f = zeros(m+1,1);

                %% Elementweiser Aufbau
                for k=1:m
                    %% Element-Knoten
                    Knoten = elemKnot(k,:);

                    %% Element-Steifigkeit und Lastvektor
                    [K_e,f_e] = ElemLS(Knoten,x,p);

                    %% Einf�gen in Steifigkeitsmatrix
                    K(Knoten,Knoten) = K(Knoten,Knoten) + K_e;

                    %% Einf�gen in Lastvektor
                    f(Knoten) =  f(Knoten) + f_e;
                end

            %%Fallunterscheidung f�r p=2 ab hier.
                
            elseif (p==2)

                %%Quadratische Formfunktionen haben 2m+1 Knoten (N_1,N_2,N_3 --> 2
                %%Knoten pro Element (ohne �berschneidung) und dann an den R�ndern

                %%Knoten
                x = linspace(-2, 2.5, 2*m+1);

                %%Zuordnung Elemente -> Knoten
                elemKnot = [(1:2:2*m-1)', (2:2:2*m)', (3:2:2*m+1)'];

                %%Speicherplatz Steifigkeitsmatrix
                K = sparse(2*m+1,2*m+1);

                %%Speicherplatz f�r Lastvektor
                f = zeros(2*m+1,1);

                %%Elementweiser Aufbau
                for k=1:m
                    %%Element-Knoten
                    Knoten = elemKnot(k,:);

                    %%Element-Steifigkeit und Lastvektor
                    [K_e,f_e] = ElemLS(Knoten,x,p);

                    %%Einf�gen in Steifigkeitsmatrix
                    K(Knoten,Knoten) = K(Knoten,Knoten) + K_e;

                    %%Einf�gen in Lastvektor
                    f(Knoten) =  f(Knoten) + f_e;
                end

            end

            % Randbedingung Dirichlet

            % Straftechnik, u(-2)=14.8
            K(1,1) = K(1,1) + 1e8;
            f(1) = f(1) + 14.8*1e8;

            % Randbedingung Neumann, u'(2.5)=-23

            %%Wieder Fallunterscheiung, wegen 2m+1 <-->m+1 Elementen in
            %%Lastvektor/Steifigkeitsmatrix.
            
            if(p==1)

                f(m+1) = f(m+1)-23;

            elseif (p==2)

                f(2*m+1) = f(2*m+1)-23;

            end

            %%LGS L�sen, \-Operator
            u = K\f;
            %%Exakte analyitsche L�sung.
            ex = (((x.^2)+2)./(x-3))+4*(x.^2);
            %%Speilereien f�r plots, Dateinamen.
            p_s = num2str(p,'%g');
            m_s = num2str(m,'%g');
            fname = strcat('m=',m_s,'p=',p_s);
            %%Fehlerermittlung
            err = max(abs(u-ex'));
            fprintf('p=%s, m=%s : Maximale Abweichung an den Knotenpunkten: %f\n', p_s,m_s,err);

            %%mit exakter L�sung vergleichen, grafisch und Bilder speichern
            
            figure
            hold on
            plot(x,ex,'-.k','LineWidth',1.3);
            plot(x,u,'^r','LineWidth',1.3);
            xlabel('x');
            ylabel('u(x)');
            legend('ex. L�s.','num. L�s.');
            savefig(sprintf('hacker_blatt6vergleich_%s.fig',fname));
            
            %string = sprintf('Genauigkeit bei p=%g, m=%g ist %f',p,m,err);
            %annotation('textbox',[0.15 0.27 0.1 0.1],'String',string,'FitBoxToText','on');
            
            hold off
            
            %%Aufr�umen.
            clear m string fname err m_s u 
        end
    end

%%Hier aufpassen: wenn man sich die plots anschauen m�chte,
%%auskommentieren.
close all    
end

%%AUSWURF::
%%
%% ------------------------------
%% hacker_blatt6aufgabe2
%% p=1, m=4 : Maximale Abweichung an den Knotenpunkten: 2.601404
%% p=1, m=8 : Maximale Abweichung an den Knotenpunkten: 1.340943
%% p=1, m=16 : Maximale Abweichung an den Knotenpunkten: 0.485577
%% p=1, m=32 : Maximale Abweichung an den Knotenpunkten: 0.140817
%% p=1, m=64 : Maximale Abweichung an den Knotenpunkten: 0.036862
%% p=1, m=128 : Maximale Abweichung an den Knotenpunkten: 0.009330
%% p=1, m=256 : Maximale Abweichung an den Knotenpunkten: 0.002340
%% p=2, m=4 : Maximale Abweichung an den Knotenpunkten: 1.032594
%% p=2, m=8 : Maximale Abweichung an den Knotenpunkten: 0.230301
%% p=2, m=16 : Maximale Abweichung an den Knotenpunkten: 0.035897
%% p=2, m=32 : Maximale Abweichung an den Knotenpunkten: 0.004033
%% p=2, m=64 : Maximale Abweichung an den Knotenpunkten: 0.000355
%% p=2, m=128 : Maximale Abweichung an den Knotenpunkten: 0.000027
%% p=2, m=256 : Maximale Abweichung an den Knotenpunkten: 0.000002
%% ------------------------------
%%
%%Fazit: gr��ere m und gr��ere p bringen mehr Genauigkeit, erfordern jedoch
%%auch mehr Rechenaufwand/Arbeit im Vorfeld - zur geeigneten
%%Formfunktions-Ermittlung, oder u.U. im 2D-Fall Triangulation.
