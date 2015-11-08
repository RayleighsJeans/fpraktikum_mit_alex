function [] = mie_spektren_rechner

clear all;

%Wellenlaenge (aus Energie der Photonen ueber lambda=h*c/E) und Vektor
lambda=(1239.841974)./[1.2:0.2:2.0 2.1 2.2 2.4 2.5 2.6 2.7 2.8 2.9 3.0 3.1]';
lambi=[min(lambda):0.01:max(lambda)]';

%Werte von n und Interpolation dazwischen
n=[0.1 0.08 0.08 0.09 0.13 0.18 0.24 0.5 0.82 1.24 1.43 1.46 1.5 1.54 1.54]';
ni=interp1(lambda,n,lambi,'spline');

%Werte von k und Interpolation dazwischen
k=[6.54 5.44 4.56 3.82 3.16 2.84 2.54 1.86 1.59 1.54 1.72 1.77 1.79 1.8 1.81]';
ki=interp1(lambda,k,lambi,'spline');

%e_m fuer waessrige Loesung mit Glasplatte, f=0.2
e_m=1.77;
f=0.219803437590171;

figure;
hold all;
grid on;
title('Real- und Imaginaerteil der Brechnung');
xlabel('\lambda/nm');
ylabel('\kappa,n');
plot(lambi,ki,'LineWidth',2.5);
plot(lambi,ni,'LineWidth',2.5);
legend('\kappa','n');
set(gca, 'FontSize', 20);
axis([400 720 0 6.5]);
hold off;

%Berechnen des Imaginaer- und Realteils von epsilon
e_re=-(ki.^2-ni.^2);
e_im=sqrt(4*(ni.^2-e_re/2).^2-e_re.^2);

figure;
hold all;
grid on;
title('Real- und Imaginaerteil der dielektrischen Funktion');
xlabel('\lambda/nm');
ylabel('\epsilon_{Re/Im}');
plot(lambi,e_re,'LineWidth',2.5);
plot(lambi,e_im,'LineWidth',2.5);
legend('\epsilon_{Re}','\epsilon_{Im}');
set(gca, 'FontSize', 20);
axis([400 720 min(e_re)-0.1*min(e_re) max(e_im)+0.1*max(e_im)]);
hold off;

%Lambda(Maxwell-Garnett) in imag und real aufteilen
L_re=(e_re.^2+e_im.^2-2.*e_m.^2+e_re.*e_m)./((e_re+2*e_m).^2+e_im.^2);
L_im=(3*e_im.*e_m)./((e_re+2*e_m).^2+e_im.^2);

%Real und Imag von effektiver dielektrischen Funktion
e_effre=e_m*(L_re*f+1-2*f^2.*L_re.^2-2*f^2.*L_im.^2)./((1-L_re*f).^2+L_im.^2*f^2);
e_effim=e_m*(3*f.*L_im)./((1-L_re*f).^2+L_im.^2*f^2);

figure;
hold all;
grid on;
title('Real- und Imaginaerteil der effektiven dielektrischen Funktion');
xlabel('\lambda/nm');
ylabel('\epsilon_{eff,Re/Im}');
plot(lambi,e_effre,'LineWidth',2.5);
plot(lambi,e_effim,'LineWidth',2.5);
legend('\epsilon_{eff,Re}','\epsilon_{eff,Im}');
set(gca, 'FontSize', 20);
axis([400 720 min(e_effim) max(e_effre)]);
hold off;

kap=sqrt(-e_effre./2+sqrt(e_effre.^2+e_effim.^2)./(2));

figure;
hold on;
grid on;
title('exp(-\kappa)');
plot(lambi, exp(-kap),'LineWidth',2.5);
legend('exp(\kappa)');
xlabel('\kappa');
ylabel('exp(-\kappa)');
set(gca, 'FontSize', 20);
axis([400 1000 min(exp(-kap))-0.1 max(exp(-kap))+0.1]);
hold off;

figure;
hold on;
grid on;
xlabel('\lambda/nm');
ylabel('\kappa');
plot(lambi, kap,'LineWidth',2.5);
legend('\kappa');
set(gca, 'FontSize', 20);
axis([400 1000 min(kap)-0.1*min(kap) max(kap)+0.1*max(kap)]);
hold off;

gamma =4*pi*kap./lambi;

load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiauair150minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiaubr90minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiauh2o90minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiauni90minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiaupro90minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiautol90minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\PEIBRedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\PEIedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\PEIH2Oedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\PEINIedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\PEIPROedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\PEITOLedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\AULSGedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\Peiauair45minedit.txt');
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\Mie-Streuung\H2Oedit.txt');

figure;
hold on;
grid on;
fprintf(1,'Maxima des Theorie-Vergleichs\n');
plot(lambi,100*gamma,'LineWidth',2.5);

[gamma_m,x] = max(100*gamma);
lamb_max = lambi(x);
fprintf(1,'Gamma -- e_m = 1.77, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

plot(H2Oedit(:,1),log(1/min((10.^(AULSGedit(:,2))-10.^(H2Oedit(:,2))))*(10.^(AULSGedit(:,2))-10.^(H2Oedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(AULSGedit(:,2))-10.^(H2Oedit(:,2))))*(10.^(AULSGedit(:,2))-10.^(H2Oedit(:,2)))));
lamb_max = lambi(x);
fprintf(1,'Au-Lsg -- e_m = 1.77, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

axis([400 720 0 4.5]);
xlabel('\lambda/nm');
ylabel('\gamma in m^{-1}, Absorptionskoeff.');
legend('\gamma_{theo}','Abs(Au-Loes.)-Abs(H_{2}O)');
set(gca, 'FontSize', 20);
hold off;

figure;
hold on;
grid on;
%plot(lambi,100*gamma,'LineWidth',2.5);
fprintf(1,'gemessene Maxima\n');
plot(H2Oedit(:,1),log(1/min(10.^(Peiauh2o90minedit(:,2))-10.^(PEIH2Oedit(:,2)))*(10.^(Peiauh2o90minedit(:,2))-10.^(PEIH2Oedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min(10.^(Peiauh2o90minedit(:,2))-10.^(PEIH2Oedit(:,2)))*(10.^(Peiauh2o90minedit(:,2))-10.^(PEIH2Oedit(:,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI_au, H2O. 90min. -- e_m = 1.77, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

plot(H2Oedit(:,1),log(1/min((10.^(Peiautol90minedit(:,2))-10.^(PEITOLedit(:,2))))*(10.^(Peiautol90minedit(:,2))-10.^(PEITOLedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(Peiautol90minedit(:,2))-10.^(PEITOLedit(:,2))))*(10.^(Peiautol90minedit(:,2))-10.^(PEITOLedit(:,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI_au,Toluol. 90min. -- e_m = 1.496, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

plot(H2Oedit(:,1),log(1/min((10.^(Peiaubr90minedit(:,2))-10.^(PEIBRedit(:,2))))*(10.^(Peiaubr90minedit(:,2))-10.^(PEIBRedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(Peiaubr90minedit(:,2))-10.^(PEIBRedit(:,2))))*(10.^(Peiaubr90minedit(:,2))-10.^(PEIBRedit(:,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI_au,Brombenzol. 90min. -- e_m = 1.5602, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

plot(H2Oedit(1:168,1),log(1/min((10.^(Peiauni90minedit(1:168,2))-10.^(PEINIedit(1:168,2))))*(10.^(Peiauni90minedit(1:168,2))-10.^(PEINIedit(1:168,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(Peiauni90minedit(1:168,2))-10.^(PEINIedit(1:168,2))))*(10.^(Peiauni90minedit(1:168,2))-10.^(PEINIedit(1:168,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI_au,Nitromethan. 90min. -- e_m = 1.3818, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

plot(H2Oedit(:,1),log(1/min((10.^(Peiaupro90minedit(:,2))-10.^(PEIPROedit(:,2))))*(10.^(Peiaupro90minedit(:,2))-10.^(PEIPROedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(Peiaupro90minedit(:,2))-10.^(PEIPROedit(:,2))))*(10.^(Peiaupro90minedit(:,2))-10.^(PEIPROedit(:,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI_au, Propandiol 90min. -- e_m = 1.43, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

xlabel('\lambda/nm');
ylabel('\gamma in m^{-1}');
axis([400 700 0 1]);
legend('Abs(PEI-Au, 90 min., H_{2}O)-Abs(PEI, H_{2}O)','Abs(PEI-Au, 90 min., Toluol)-Abs(PEI, Toluol)','Abs(PEI-Au, 90 min., Bromb.)-Abs(PEI, Bromb.)','Abs(PEI-Au, 90 min., Nitr.)-Abs(PEI, Nitr.)','Abs(PEI-Au, 90 min., Propandiol)-Abs(PEI, Prop.)');
set(gca, 'FontSize', 20);
hold off;

figure;
hold on;
grid on;
fprintf(1,'Maxima aus Luft\n');

plot(H2Oedit(:,1),log(1/min((10.^(Peiauair150minedit(:,2))-10.^(PEIedit(:,2))))*(10.^(Peiauair150minedit(:,2))-10.^(PEIedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(Peiauair150minedit(1:126,2))-10.^(PEIedit(1:126,2))))*(10.^(Peiauair150minedit(1:126,2))-10.^(PEIedit(1:126,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI Au Luft 150min. -- e_m = 1, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

plot(H2Oedit(:,1),log(1/min((10.^(Peiauair45minedit(:,2))-10.^(PEIedit(:,2))))*(10.^(Peiauair45minedit(:,2))-10.^(PEIedit(:,2)))),'LineWidth',2.5);

[gamma_m,x] = max(log(1/min((10.^(Peiauair45minedit(1:126,2))-10.^(PEIedit(1:126,2))))*(10.^(Peiauair45minedit(1:126,2))-10.^(PEIedit(1:126,2)))));
lamb_max = lambi(x);
fprintf(1,'PEI Au Luft 45min. -- e_m = 1, gamma_max = %d m^{-1}, lambda_max = %d nm\n', gamma_m, lamb_max);

xlabel('\lambda/nm');
ylabel('\gamma in m^{-1}');
axis([320 700 0 1]);
legend('Abs(PEI-Au, 150 min., Luft)-Abs(PEI, Luft)','Abs(PEI-Au, 45 min., Luft)-Abs(PEI, Luft)');
set(gca, 'FontSize', 20);
hold off;

figure;
hold on;
grid on;
set(gca,'FontSize',20);
xlabel('\lambda');
ylabel('\gamma(\lambda) in m^{-1}')
fprintf(1,'Theoretische Werte\n');
for e_m = [1.77 1.3818 1.43 1.496 1.5602];
    e_effre=e_m*(L_re*f+1-2*f^2.*L_re.^2-2*f^2.*L_im.^2)./((1-L_re*f).^2+L_im.^2*f^2);
    e_effim=e_m*(3*f.*L_im)./((1-L_re*f).^2+L_im.^2*f^2);
    kap=sqrt(-e_effre./2+sqrt(e_effre.^2+e_effim.^2)./(2));
    gamma =4*pi*kap./lambi;
    plot(lambi,100*gamma,'LineWidth',2.5);
    [gam_max,x] = max(gamma);
    lam_max = lambi(x);
    fprintf(1,'e_m = %d -- gamma_max = %d 1/m, lambda_max = %d nm\n', e_m, gam_max, lam_max); 
end;
legend('\epsilon_{m}=1.77, Wasser','\epsilon_{m}=1.3818, Nitromethan','\epsilon_{m}=1.5602, Brombenzol','\epsilon_{m}=1.496, Toluol','\epsilon_{m}=1.43, Propandiol');
axis([528 546 2.8 3.8]);
hold off;

load('xray150.DAT');

figure;
hold on;
grid on;
set(gca,'FontSize',20);
plot(xray150(:,1)*10,xray150(:,2),'LineWidth',2.5);
axis([0 1.2 0 max(xray150(:,2))]);
legend('Roentgenreflektometrie-Daten');
xlabel('q_{z}/nm^{-1}');
ylabel('Intensitaet, a.u.');
hold off;

clear all;

end