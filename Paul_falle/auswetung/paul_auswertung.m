function [] = paul_auswertung

clear all
close all

%%Einladen der Daten.

%%Frequenzvariation, von 1000 bis 1.5e6 Hz der ext. Manipulation vor dem
%%Auswurf mit 350kHz. Vollst�ndige Intensit�t.

    %%Exp. Daten mit Maniopulation.
    freqsweep_15e5Hz_ex  = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\freqsweep_1_1,5e3khz_exc.dat');

    %%Referenzsignale ohne Manipulation.
    freqsweep_15e5Hz_ref = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\freqsweep_1_1,5e3khz_ref.dat');

    %%Nur die 1. Iteration der Experimentellen Daten --> bestes, einzig verwertbares
    %%Signal!
    freqsweep_15e5Hz_ex1it = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\freqsweep_1_1,5e3khz_exc_1it.dat');

    %%1. Iteration des Referenzsignals.
    freqsweep_15e5Hz_ref1it = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\freqsweep_1_1,5e3khz_ref_1it.dat');
    
%%Frequenzvariation des prim�ren Auswurfs der DATA_AQUISITION, von 100000
%%bis 500000 Hz. Vollst�ndige Intensit�t.
freqsweep_5e5Hz = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\frequenzseep_1e5-5e5hz.dat');

%%50 Iterationen (Voranschreiten der Zeit des Experimentes f�r die
%%Beobachtung des Signalverlusts. 50ms zwischen 2 inneren Interationen von
%%10. Ein einziger Scan hat damit 10*(10000(egun)�s+1000(ext.
%%anregung)�s+10000(warten) �s+20000(DAQ)�s+50000(warten)�s) = 910000�s.
%%Vollst�ndige Intensit�t.

    %%Hier die ext. Manipulation eingeschaltet.
    scan_50ms_warte_ex = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\scan_50it_warte50ms_zw_ex_ref_ex.dat');

    %%Hier das Referenz-Signal.
    scan_50ms_warte_ref = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\scan_50it_warte50ms_zw_ex_ref_ref.dat');

%%Variation der Wartezeit zwischen E-Gun und DAQ --> Zerfall
%%(weg-oszillieren) der Ionenspezies?! Nur der gro�e Peak bis Kanal 500,00
%%(Rauschen nicht aufintegriert).
warte_var = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Paul_falle\daten\wartezeit_1e3_5e5�s.dat');

%%Freq.intervall f�r die ersten,gro�en Daten.
freq_15e5Hz = linspace(1000,1500000,1500)';

%%Freq.intervall.
freq_5e5Hz = linspace(100000,500000,41)';

%%Frequenzen des prim�ren Auswurfs f�r die DAQ
auswurf = warte_var(:,2);

%%Zeit als Dauer des Experiments bei 50 Iterationen und einer einfachen
%%Zyklusdauer von 910000�s.
time = linspace(910000,50*910000,50)';

%%Schaue mir zuerst die vollen Daten an.
% figure
% hold on
% grid on; grid minor
% plot(1/1000.*freq_15e5Hz,freqsweep_15e5Hz_ex,'LineWidth',1.2);
% plot(1/1000.*freq_15e5Hz,freqsweep_15e5Hz_ref,'LineWidth',1.2);
% legend('Resonanzverlauf der Manipulation','Referenzsignal');
% xlabel('Frequenz in kHz');
% ylabel('Intensit�t, Counts �ber 10 It.');
% axis([1 1500 min(freqsweep_15e5Hz_ex) max(freqsweep_15e5Hz_ref)]);
% set(gca, 'FontSize', 22);
% savefig('volle_daten.fig');
% hold off

% %%Und dann die erste Iteration und finde heraus: hier stecken alle meine
% %%Daten, die ich verwerten kann!
% figure
% hold on
% grid on; grid minor
% plot(1/1000.*freq_15e5Hz,freqsweep_15e5Hz_ex1it,'LineWidth',1.2);
% plot(1/1000.*freq_15e5Hz,freqsweep_15e5Hz_ref1it,'LineWidth',1.2);
% legend('Resonanzverlauf der Manipulation, 1. It.','Referenzsignal, 1. It.');
% xlabel('Frequenz in kHz');
% ylabel('Intensit�t, Counts �ber 10 It.');
% axis([1 1500 min(freqsweep_15e5Hz_ex1it) max(freqsweep_15e5Hz_ref1it)]);
% set(gca, 'FontSize', 22);
% savefig('erste_it.fig');
% hold off

%%Mache Trick, um mir Schreibarbeit zu sparen: sage, volle Daten = 1.
%%Iteration. Werfe damit Fehler raus.
freqsweep_15e5Hz_ex = freqsweep_15e5Hz_ex1it;
freqsweep_15e5Hz_ref = freqsweep_15e5Hz_ref1it;

% figure
% hold on
% grid on; grid minor
% plot(1/1000.*auswurf,1/max(warte_var(:,1)).*warte_var(:,1),'-.^k','LineWidth',1.4);
% legend('Variation der Wartezeit zwischen Ionisation und Auswurf');
% xlabel('Zeit in ms');
% ylabel('Normierte Intensit�t I/I_{0}');
% axis([1 500 0 1.1]);
% set(gca, 'FontSize', 22);
% savefig('wartezeit.fig');
% hold off

% h = figure;
% hold on
% grid on; grid minor
% plot(1/1000.*auswurf(4:end),log(warte_var(4:end,1)),'-.^k','LineWidth',1.4);
% hold off

% linear_wartezeit = ezfit('poly1');
% showfit(linear_wartezeit);

% legend('Ln(*) der Intensit�t �ber Wartezeit');
% xlabel('\tau/10^{3}�s');
% ylabel('ln(I)');
% axis([10 500 min(log(warte_var(4:end,1))) max(log(warte_var(4:end,1)))]);
% set(gca, 'FontSize', 22);
% savefig('linear_fit_wartezeit.fig');
% % close(h);

% figure
% hold on
% grid on; grid minor
% plot(1/1000.*freq_5e5Hz,1/max(freqsweep_5e5Hz).*freqsweep_5e5Hz,'-.^k','LineWidth',1.4);
% legend('Frequenz-Variation des prim�ren Auswurfs vor DAQ');
% xlabel('Frequenz in kHz');
% ylabel('Normierte Intensit�t I/I_{0}');
% axis([100 500 0 1.05]);
% set(gca, 'FontSize', 22);
% savefig('freq_auswurf.fig');
% hold off

        %%Mach mir smoothe Iterationsspektren. Ex. und Ref.!

        Hz15e5_ex_s = zeros(270,1);
        Hz15e5_ref_s = zeros(270,1);

        %%Muss noch das Mittel bestimmen, um dieses abzuziehen.
        %%Detektor-0-Aktivit�t.
           
        Hz15e5_ex_mean = sum(freqsweep_15e5Hz_ex(271:end))./(1500-270);
        Hz15e5_ref_mean = sum(freqsweep_15e5Hz_ref(271:end))./(1500-270);
        
            %%Smoothes Ex.    

            for i=4:270
                Hz15e5_ex_s(i) = (freqsweep_15e5Hz_ex(i-3)+freqsweep_15e5Hz_ex(i-2)+freqsweep_15e5Hz_ex(i-1)+freqsweep_15e5Hz_ex(i)+freqsweep_15e5Hz_ex(i+1)+freqsweep_15e5Hz_ex(i+2)+freqsweep_15e5Hz_ex(i+3))/7;
            end
            Hz15e5_ex_s(1) = (freqsweep_15e5Hz_ex(1)+freqsweep_15e5Hz_ex(2)+freqsweep_15e5Hz_ex(3))/3;
            Hz15e5_ex_s(2) = (freqsweep_15e5Hz_ex(1)+freqsweep_15e5Hz_ex(2)+freqsweep_15e5Hz_ex(3)+freqsweep_15e5Hz_ex(4))/4;
            Hz15e5_ex_s(3) = (freqsweep_15e5Hz_ex(1)+freqsweep_15e5Hz_ex(2)+freqsweep_15e5Hz_ex(3)+freqsweep_15e5Hz_ex(4)+freqsweep_15e5Hz_ex(5))/5;

            %%Smoothes Ref.

            for i=4:270
                Hz15e5_ref_s(i) = (freqsweep_15e5Hz_ref(i-3)+freqsweep_15e5Hz_ref(i-2)+freqsweep_15e5Hz_ref(i-1)+freqsweep_15e5Hz_ref(i)+freqsweep_15e5Hz_ref(i+1)+freqsweep_15e5Hz_ref(i+2)+freqsweep_15e5Hz_ref(i+3))/7;
            end
            Hz15e5_ref_s(1) = (freqsweep_15e5Hz_ref(1)+freqsweep_15e5Hz_ref(2)+freqsweep_15e5Hz_ref(3))/3;
            Hz15e5_ref_s(2) = (freqsweep_15e5Hz_ref(1)+freqsweep_15e5Hz_ref(2)+freqsweep_15e5Hz_ref(3)+freqsweep_15e5Hz_ref(4))/4;
            Hz15e5_ref_s(3) = (freqsweep_15e5Hz_ref(1)+freqsweep_15e5Hz_ref(2)+freqsweep_15e5Hz_ref(3)+freqsweep_15e5Hz_ref(4)+freqsweep_15e5Hz_ref(5))/5;

        %%Ziehe noch das, nach der 271 It. verbleibende Rauschen ab.
        %%Ist sozusagen das Mittel von da bis zum Ende.

        Hz15e5_ex_s = Hz15e5_ex_s-Hz15e5_ex_mean;
        Hz15e5_ref_s = Hz15e5_ref_s-Hz15e5_ref_mean;

        %%Mittel der Differenz.
            
        Hz15e5_com_mean = sum(abs(freqsweep_15e5Hz_ref(271:end)-freqsweep_15e5Hz_ex(271:end)))./(1500-270);
            
        %%Brauche noch die smoothe Differenz zur Resonanzbestimmung.
        
        Hz15e5_diff = zeros(273,1);
        Hz15e5_diff_s = zeros(270,1);
        
        %%Differenz zwischen Ex. und Ref. zusammen mit Mittel der Diff.
        
        Hz15e5_diff = freqsweep_15e5Hz_ref(1:273)-freqsweep_15e5Hz_ex(1:273)-Hz15e5_com_mean;
            
            %%Smoothen der Differenz.

            for i=4:270
                Hz15e5_diff_s(i) = (Hz15e5_diff(i-3)+Hz15e5_diff(i-2)+Hz15e5_diff(i-1)+Hz15e5_diff(i)+Hz15e5_diff(i+1)+Hz15e5_diff(i+2)+Hz15e5_diff(i+3))/7;
            end
            Hz15e5_diff_s(1) = (Hz15e5_diff(1)+Hz15e5_diff(2)+Hz15e5_diff(3))/3;
            Hz15e5_diff_s(2) = (Hz15e5_diff(1)+Hz15e5_diff(2)+Hz15e5_diff(3)+Hz15e5_diff(4))/4;
            Hz15e5_diff_s(3) = (Hz15e5_diff(1)+Hz15e5_diff(2)+Hz15e5_diff(3)+Hz15e5_diff(4)+Hz15e5_diff(5))/5;
        
        
% figure
% hold on
% grid on; grid minor
% plot(1/1000.*freq_15e5Hz(1:270),1/max(Hz15e5_ex_s(:)).*Hz15e5_ex_s,'-.sb','LineWidth',1.4);
% plot(1/1000.*freq_15e5Hz(1:270),1/max(Hz15e5_ref_s(:)).*Hz15e5_ref_s,':^r','LineWidth',1.4);
% legend('Frequenz-Variation der Manipultaion, Ex.1','Daten zur Referenz');
% xlabel('Frequenz in kHz');
% ylabel('Normierte Intensit�t, a.u.');
% axis([1 270 -0.05 1.05]);
% set(gca, 'FontSize', 22);
% savefig('freq_manip.fig');
% hold off
% 
% figure
% hold on
% grid on; grid minor
% plot(1/1000.*freq_15e5Hz(1:270),Hz15e5_diff_s./max(Hz15e5_diff_s),'-.^k','LineWidth',1.4);
% legend('Resonanzverlauf, I_{ref}-I_{ex}');
% xlabel('Frequenz in kHz');
% ylabel('Normierte Intensit�t, a.u.');
% axis([1 270 -.06 1.05]);
% set(gca, 'FontSize', 22);
% savefig('freq_diff.fig');
% hold off

        %%Smoothe den Signalabfall.
        
        dec_ref_s = zeros(50,1);
        dec_ex_s = zeros(50,1);
        
        %%Experimental-Sig.
        for i=4:47
            dec_ex_s(i) = (scan_50ms_warte_ex(i-3)+scan_50ms_warte_ex(i-2)+scan_50ms_warte_ex(i-1)+scan_50ms_warte_ex(i)+scan_50ms_warte_ex(i+1)+scan_50ms_warte_ex(i+2)+scan_50ms_warte_ex(i+3))/7;
        end
        dec_ex_s(1) = (scan_50ms_warte_ex(1)+scan_50ms_warte_ex(2)+scan_50ms_warte_ex(3))/3;
        dec_ex_s(2) = (scan_50ms_warte_ex(1)+scan_50ms_warte_ex(2)+scan_50ms_warte_ex(3)+scan_50ms_warte_ex(4))/4;
        dec_ex_s(3) = (scan_50ms_warte_ex(1)+scan_50ms_warte_ex(2)+scan_50ms_warte_ex(3)+scan_50ms_warte_ex(4)+scan_50ms_warte_ex(5))/5;
        dec_ex_s(50) = (scan_50ms_warte_ex(50)+scan_50ms_warte_ex(49)+scan_50ms_warte_ex(48))/3;
        dec_ex_s(49) = (scan_50ms_warte_ex(50)+scan_50ms_warte_ex(49)+scan_50ms_warte_ex(48)+scan_50ms_warte_ex(47))/4;
        dec_ex_s(48) = (scan_50ms_warte_ex(48)+scan_50ms_warte_ex(49)+scan_50ms_warte_ex(50)+scan_50ms_warte_ex(47)+scan_50ms_warte_ex(46))/5;
        
        %%Referenz.
        for i=4:47
            dec_ref_s(i) = (scan_50ms_warte_ref(i-3)+scan_50ms_warte_ref(i-2)+scan_50ms_warte_ref(i-1)+scan_50ms_warte_ref(i)+scan_50ms_warte_ref(i+1)+scan_50ms_warte_ref(i+2)+scan_50ms_warte_ref(i+3))/7;
        end
        dec_ref_s(1) = (scan_50ms_warte_ref(1)+scan_50ms_warte_ref(2)+scan_50ms_warte_ref(3))/3;
        dec_ref_s(2) = (scan_50ms_warte_ref(1)+scan_50ms_warte_ref(2)+scan_50ms_warte_ref(3)+scan_50ms_warte_ref(4))/4;
        dec_ref_s(3) = (scan_50ms_warte_ref(1)+scan_50ms_warte_ref(2)+scan_50ms_warte_ref(3)+scan_50ms_warte_ref(4)+scan_50ms_warte_ref(5))/5;
        dec_ref_s(50) = (scan_50ms_warte_ref(50)+scan_50ms_warte_ref(49)+scan_50ms_warte_ref(48))/3;
        dec_ref_s(49) = (scan_50ms_warte_ref(50)+scan_50ms_warte_ref(49)+scan_50ms_warte_ref(48)+scan_50ms_warte_ref(47))/4;
        dec_ref_s(48) = (scan_50ms_warte_ref(48)+scan_50ms_warte_ref(49)+scan_50ms_warte_ref(50)+scan_50ms_warte_ref(47)+scan_50ms_warte_ref(46))/5;

%%Schaue mir das Signal �ber 50 �u�ere (10 innere) Iterationen an. Mit
%%Anregung.
figure
hold on
grid on; grid minor
plot(1e-6.*time,dec_ex_s,':sr','LineWidth',1.5);

f = 'a*x+b';
wurzel = ezfit(f);
showfit(wurzel);

plot(1e-6.*time,dec_ref_s,'-.^b','LineWidth',1.5);
xlabel('Zeit in 10^{3}ms');
ylabel('Intensit�t, Counts in 10 It.');
legend('Signalintens., mit Anregung','ohne Anregung');
set(gca, 'FontSize', 22);
axis([1e-6*time(1) 1e-6*time(end) min(dec_ref_s) max(dec_ref_s)]);
savefig('signal_abfall.fig');
hold off

%%Versuche krassen Shit mit dem richtigen Spektrum
Z = imread('referenz_raw.bmp');
Z = Z(:,:,1);

%%Schreibe erst mal das REF bin�r hin.
for i=1:1361
    for j=1:291
        
        if (Z(j,i)<127)
            Z(j,i)=0;
        else
            Z(j,i)=1;
        end
        
    end
end

ref_freq = linspace(0,800,1361);
l_freq = int32(270/(800/1361));

tmp = 0;
k = 0;
main = zeros(1361,1);

%%Schreibe jetzt einen Kanal hin (definites Messsignal).
for i=1:1361
    for j=1:291
        
        if (Z(j,i)==1)
            tmp = tmp+j;
            k = k+1;
        end
        
    end

    main(i) = tmp/k;
    
    tmp = 0;
    k = 0;
end


%%Beides zusammen plotten.
% figure
% hold on
% grid on; grid minor
% plot(1/1000.*freq_15e5Hz(1:270),-Hz15e5_diff_s+2.*abs(min(-main(1:int32(270/(800/1361))))),'-.^k','LineWidth',1.4);
% plot(ref_freq(1:int32(270/(800/1361))),-main(1:int32(270/(800/1361)))+2.*abs(min(-main(1:int32(270/(800/1361))))),':xr','LineWidth',1.4)
% xlabel('Frequenz in kHz');
% ylabel('Normierte Intensit�t, a.u.');
% axis([0 270 min(-main(1:int32(270/(800/1361)))+2.*abs(min(-main(1:int32(270/(800/1361))))))-10 max(-Hz15e5_diff_s+2.*abs(min(-main(1:int32(270/(800/1361))))))+10])
% legend('Messdaten der Resonanz','Literaturwerte, Leuthner et. al.');
% set(gca, 'FontSize', 22);
% savefig('freq_vergleich.fig');
% hold off

keyboard
save('all_paul-trap.mat');
clear all
end