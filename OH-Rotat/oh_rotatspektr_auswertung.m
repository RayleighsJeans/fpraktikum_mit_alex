function [] = oh_rotatspektr_auswertung

warning off;

clear all

spektr_1 = zeros(511,3);
spektr_2 = zeros(511,3);

spektr_1 = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\OH-Rotat\OH - Praktikum. M.Sc. Stud. Physik\Rohspektren 1 und 2\20150525_andor_data.dat');
spektr_2 = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\OH-Rotat\OH - Praktikum. M.Sc. Stud. Physik\Rohspektren 1 und 2\20150319_andor_data.dat');

sim_1_247p996K_1p0 = zeros(661,3);
sim_2_152p0_1p0 = zeros(661,3);
sim_3_200p0_1p0 = zeros(661,3);

sim_1_247p996K_1p0 = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\OH-Rotat\OH - Praktikum. M.Sc. Stud. Physik\Simulierte Spektren\oh_spec_T_247p996_FWHM_1p0.dat');
sim_2_152p0_1p0 = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\OH-Rotat\OH - Praktikum. M.Sc. Stud. Physik\Simulierte Spektren\oh_spec_T_152p0_FWHM_1p0.dat');
sim_3_200p0_1p0 = load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\OH-Rotat\OH - Praktikum. M.Sc. Stud. Physik\Simulierte Spektren\oh_spec_T_200p0_FWHM_1p0.dat');

lambda_sim = zeros(661,1);
lambda_sim = sim_1_247p996K_1p0(:,1);

% figure;
% hold all;
% plot(lambda_sim,sim_1_247p996K_1p0(:,3),'--x','LineWidth',1.3);
% % plot(lambda_sim,sim_2_152p0_1p0(:,3),'--o','LineWidth',1.3);
% % plot(lambda_sim,sim_3_200p0_1p0(:,3),'--^','LineWidth',1.3);
% legend('Sim. 1, T=247.996K, FWHM=1.0','Sim. 2, T=152.0K, FWHM=1.0','Sim. 3, T=200.0K, FWHM=1.0');
% xlabel('\lambda/nm');
% ylabel('normierte Intensität, a.u.');
% grid on;
% set(gca, 'FontSize', 22);
% savefig('sim_spektr.fig');
% hold off;

s_1 = zeros(511,1);
s_2 = zeros(511,1);

s_1_or = zeros(511,1);
s_2_or = zeros(511,1);

diff = zeros(511,1);
lambda = zeros(511,1);

lambda(:) = 1000.*spektr_1(:,1);

s_1_or(1:end-1) = abs(spektr_1(1:end-1,2)-spektr_1(1:end-1,3));
s_2_or(1:end-1) = abs(spektr_2(1:end-1,2)-spektr_2(1:end-1,3));

s_1 = s_1_or*1/max(abs(spektr_1(1:end-1,2)-spektr_1(1:end-1,3)));
s_2 = s_2_or*1/max(abs(spektr_2(1:end-1,2)-spektr_2(1:end-1,3)));

%PLOT DER UNSMOOTHIGEN SPEKTREN
% figure;
% hold all;
% plot(lambda(1:end-1),s_1(1:end-1),'--xr','Linewidth',1.8);
% plot(lambda(1:end-1),s_2(1:end-1),'--ob','Linewidth',1.8);
% axis([1503.92 1599.98 0 1 ]);
% legend('OH(3-1), 25.05.2015','OH(3-1), 19.03.2015');
% xlabel('\lambda/nm');
% ylabel('normierte Intensität, a.u.');
% grid on;
% set(gca, 'FontSize', 22);
% savefig('spektr_unsmooth.fig');
% hold off;

%SMOOTHING; Polynomische Form (7.Ordnung)

for i=4:507
    s_1(i) = (s_1(i-3)+s_1(i-2)+s_1(i-1)+s_1(i)+s_1(i+1)+s_1(i+2)+s_1(i+3))/7;
end
s_1(1) = (s_1(1)+s_1(2)+s_1(3))/3;
s_1(2) = (s_1(1)+s_1(2)+s_1(3)+s_1(4))/4;
s_1(3) = (s_1(1)+s_1(2)+s_1(3)+s_1(4)+s_1(5))/5;
s_1(508) = (s_1(506)+s_1(507)+s_1(508)+s_1(509)+s_1(510))/5;
s_1(509) = (s_1(507)+s_1(508)+s_1(509)+s_1(510))/4;
s_1(510) = (s_1(508)+s_1(509)+s_1(510))/3;

for i=4:507
    s_2(i) = (s_2(i-3)+s_2(i-2)+s_2(i-1)+s_2(i)+s_2(i+1)+s_2(i+2)+s_2(i+3))/7;
end
s_2(1) = (s_2(1)+s_2(2)+s_2(3))/3;
s_2(2) = (s_2(1)+s_2(2)+s_2(3)+s_2(4))/4;
s_1(3) = (s_2(1)+s_2(2)+s_2(3)+s_2(4)+s_2(5))/5;
s_1(508) = (s_2(506)+s_2(507)+s_2(508)+s_2(509)+s_2(510))/5;
s_2(509) = (s_2(507)+s_2(508)+s_2(509)+s_2(510))/4;
s_2(510) = (s_2(508)+s_2(509)+s_2(510))/3;

%DIFFERENZ
diff(1:end-1) = abs((spektr_2(1:end-1,2)-spektr_2(1:end-1,3))-(spektr_1(1:end-1,2)-spektr_1(1:end-1,3)));

for i=3:508
    diff(i) = (diff(i-2)+diff(i-1)+diff(i)+diff(i+1)+diff(i+2))/5;
end
diff(1) = (diff(1)+diff(2)+diff(3))/3;
diff(2) = (diff(1)+diff(2)+diff(3)+diff(4))/4;
diff(509) = (diff(507)+diff(508)+diff(509)+diff(510))/4;
diff(510) = (diff(508)+diff(509)+diff(510))/3;

% %PLOT DER SMOOTHEN SPEKTREN
% figure;
% hold all;
% plot(lambda(1:end-1),s_1(1:end-1),'--xr','Linewidth',1.8);
% plot(lambda(1:end-1),s_2(1:end-1),'--ob','Linewidth',1.8);
% axis([1503.92 1599.98 0 1 ]);
% legend('OH(3-1), 25.05.2015','OH(3-1), 19.03.2015');
% xlabel('\lambda/nm');
% ylabel('normierte Intensität, a.u.');
% grid on;
% set(gca, 'FontSize', 22);
% savefig('spektr_smooth.fig');
% hold off;

%PLOT DER DIFFERENZ
% figure;
% hold all;
% plot(lambda(1:end-1),diff(1:end-1),'--xk','Linewidth',1.8);
% axis([lambda(85) lambda(242) min(diff(85:242))-10 max(diff(85:242))+10]);
% legend('|I/I_{0}(25.05.2015)-I/I_{0}(19.03.2015)|');
% xlabel('\lambda/nm');
% ylabel('Intensität, a.u.');
% grid on;
% set(gca, 'FontSize', 22);
% savefig('diff_smooth.fig');
% hold off;


%AUSWERTUNG
%Literaturwerte
ek_m = [16.742 20.367 21.823];
ek_tul = [17.119 20.732 22.112];
ek_lang = [9.998 12.327 13.367];

h = 6.62607004*10^(-34);
c = 2.99792458*10^(8);
k_b = 1.380648*10^(-23);

FJ = 100.*[-42.0 32.9 138.4];
J = [3/2 5/2 7/2];
lam_oh = [1524 1533 1543];

%1524 --> 105
%1533 --> 152
%1543 --> 205

I = zeros(6,1);
lam_max = zeros(6,1);

[I(1),x] = max(s_1_or(85:137));
lam_max(1) = lambda(85+x);
clear x
[I(2),x] = max(s_1_or(138:189));
lam_max(2) = lambda(138+x);
clear x
[I(3),x] = max(s_1_or(190:242));
lam_max(3) = lambda(190+x);
clear x
[I(4),x] = max(s_2_or(85:137));
lam_max(4) = lambda(85+x);
clear x
[I(5),x] = max(s_2_or(138:189));
lam_max(5) = lambda(138+x);
clear x
[I(6),x] = max(s_2_or(190:242));
lam_max(6) = lambda(190+x);
clear x

t_rot = zeros(6,1);

energie = zeros(3,1);
energie = h*c.*FJ/k_b;

%Lösen für 1. Spektrum
a_m = zeros(3,1);
a_tul = zeros(3,1);
a_lang = zeros(3,1);

a_m = -log(I(1:3)./(2.*(2.*J(1:3)'+1).*ek_m(1:3)'));
a_tul = -log(I(1:3)./(2.*(2.*J(1:3)'+1).*ek_tul(1:3)'));
a_lang = -log(I(1:3)./(2.*(2.*J(1:3)'+1).*ek_lang(1:3)'));

t_rot(1) = 1./(energie'\a_m);
t_rot(2) = 1./(energie'\a_tul);
t_rot(3) = 1./(energie'\a_lang);

%Lösen für 2. Spektrum
b_m = zeros(3,1);
b_tul = zeros(3,1);
b_lang = zeros(3,1);

b_m = -log(I(4:6)./(2.*(2.*J(1:3)'+1).*ek_m(1:3)'));
b_tul = -log(I(4:6)./(2.*(2.*J(1:3)'+1).*ek_tul(1:3)'));
b_lang = -log(I(4:6)./(2.*(2.*J(1:3)'+1).*ek_lang(1:3)'));

t_rot(4) = 1./(energie'\b_m);
t_rot(5) = 1./(energie'\b_tul);
t_rot(6) = 1./(energie'\b_lang);

fprintf(1,'Intensitäten der Peaks 1-3, Spektrum A\n');
disp(I(1:3))
fprintf(1,'Wellenlängen der Peaks 1-3, Spektrum A\n');
disp(lam_max(1:3))
fprintf(1,'Intensitäten der Peaks 1-3, Spektrum B\n');
disp(I(4:6))
fprintf(1,'Wellenlängen der Peaks 1-3, Spektrum B\n');
disp(lam_max(4:6))

% figure;
% hold on;
% plot(energie,a_m,'-.xr','Linewidth',2);
% plot(energie,a_tul,'-.ob','Linewidth',2);
% plot(energie,a_lang,'-.sg','Linewidth',2);
% plot(energie,b_m,':dy','Linewidth',2);
% plot(energie,b_tul,':^m','Linewidth',2);
% plot(energie,b_lang,':pc','Linewidth',2);
% axis([-61 201 -1.2 0.8]);
% xlabel('Rotationsenergie, (hcF(J)_{\nu,i})/k_{B} in K');
% ylabel('ln(I_{J,\nu}/(2(2J+1)*A_{J,\nu}))');
% legend('n. Mies (Spektr. A)','n. T.u.L. (Spektr. A)','n. Langh. (Spektr. A)','n. Mies (Spektr. B)','n. T.u.L. (Spektr. B)','n. Langh. (Spektr. B)');
% grid on;
% set(gca, 'FontSize', 22);
% savefig('lin_reg.fig');
% hold off;

%Fehlerrechnung für minimale Intensitäten --> Standardabweichung

mean_1_1 = sum(s_1(110:147))/(147-110);
mean_1_2 = sum(s_1(157:200))/(200-157);

if (mean_1_1<mean_1_2)
    mean_1 = mean_1_1;
    sigma1 = (1/(147-110-1).*(sum((s_1(110:147)).^2)-2.*mean_1.*sum(s_1(110:147))+mean_1.^2*(147-110)))^(1/2);
elseif (mean_1_1>mean_1_2)
    mean_1 = mean_1_2;
    sigma1 = (1/(200-157-1).*(sum((s_1(157:200)).^2)-2.*mean_1.*sum(s_1(157:200))+mean_1.^2*(200-157)))^(1/2);
end

mean_2_1 = sum(s_2(110:147))/(147-110);
mean_2_2 = sum(s_2(157:200))/(200-157);

if (mean_2_1<mean_2_2)
    mean_2 = mean_2_1;
    sigma2 = (1/(147-110-1).*(sum((s_2(110:147)).^2)-2.*mean_1.*sum(s_2(110:147))+mean_1.^2*(147-110)))^(1/2);
elseif (mean_2_1>mean_2_2)
    mean_2 = mean_2_2;
    sigma2 = (1/(200-157-1).*(sum((s_2(157:200)).^2)-2.*mean_1.*sum(s_2(157:200))+mean_1.^2*(200-157)))^(1/2);
end

%FEHLER 1. SPEKTRUM
err1 = zeros(3,1);
err1 = ((-c*h.*FJ(1:3)'./(k_b.*I(1:3).*log((I(1:3))./(2.*ek_m(1:3)'.*(2.*J(1:3)'+1))).^2)).^2.*(sigma1).^2).^(1/2);

fprintf(1,'Fehler im Spektrum A, Gauß\n');
disp(err1)


t_1p = 1./(energie'\(-log((I(1:3)+sigma1)./(2.*(2.*J(1:3)'+1).*ek_m(1:3)'))));
t_1m = 1./(energie'\(-log((I(1:3)-sigma1)./(2.*(2.*J(1:3)'+1).*ek_m(1:3)'))));

%FEHLER 2. SPEKTRUM
err2 = zeros(3,1);
err2 = ((-c*h.*FJ(1:3)'./(k_b.*I(4:6).*log((I(4:6))./(2.*ek_m(1:3)'.*(2.*J(1:3)'+1))).^2)).^2.*(sigma2).^2).^(1/2);

fprintf(1,'Fehler im Spektrum B, Gauß\n');
disp(err2)

t_2p = 1./(energie'\(-log((I(4:6)+sigma2)./(2.*(2.*J(1:3)'+1).*ek_m(1:3)'))));
t_2m = 1./(energie'\(-log((I(4:6)-sigma2)./(2.*(2.*J(1:3)'+1).*ek_m(1:3)'))));

%TEMPERATUREN
fprintf(1,'T_rot\n Reihenfolge: Spektrum A (Mies, T.u.L., Langh.) --> Spektrum B ...\n');
disp(t_rot)

%FINALLY
fprintf(1,'Fehler durch Abweichung in linearer Regression\n Reihenfolge: Spektr. 1(+,-) --> Spektr. 2(+,-)\n %d\n %d\n %d\n %d\n %d\n %d\n',t_1p,t_1m,t_2p,t_2m);

%SPEICHERN
save('oh_rotat_auswertung.mat');
clear all
end