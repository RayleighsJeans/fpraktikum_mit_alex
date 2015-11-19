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

figure;
hold all;
plot(lambda_sim,sim_1_247p996K_1p0(:,3),'LineWidth',2.5);
plot(lambda_sim,sim_2_152p0_1p0(:,3),'LineWidth',2.5);
plot(lambda_sim,sim_3_200p0_1p0(:,3),'LineWidth',2.5);
legend('Sim. 1, T=247.996K, FWHM=1.0','Sim. 2, T=152.0K, FWHM=1.0','Sim. 3, T=200.0K, FWHM=1.0');
xlabel('\lambda/nm');
ylabel('normierte Intensitšt, a.u.');
grid on;
set(gca, 'FontSize', 22);
savefig('sim_spektr.fig');
hold off;

s_1 = zeros(511,1);
s_2 = zeros(511,1);
diff = zeros(511,1);
lambda = zeros(511,1);
smth_1 = zeros(511,1);

lambda(:) = 1000.*spektr_1(:,1);
s_1(1:end-1) = (spektr_1(1:end-1,2)-spektr_1(1:end-1,3))*1/max(abs(spektr_1(1:end-1,2)-spektr_1(1:end-1,3)));
smth_1(1:end-1) = smooth(s_1(1:end-1),'sgolay',5);
s_2(1:end-1) = (spektr_2(1:end-1,2)-spektr_2(1:end-1,3))*1/max(abs(spektr_2(1:end-1,2)-spektr_2(1:end-1,3)));
diff(1:end-1) = abs((spektr_2(1:end-1,2)-spektr_2(1:end-1,3))-(spektr_1(1:end-1,2)-spektr_1(1:end-1,3)))*1/max(abs((spektr_2(1:end-1,2)-spektr_2(1:end-1,3))-(spektr_1(1:end-1,2)-spektr_1(1:end-1,3))));

figure;
hold all;
%plot(lambda(1:end-1),s_2(1:end-1),'LineWidth',2.5);
plot(lambda(1:end-1),smth(1:end-1),'LineWidth',2.5);
legend('OH(3-1), 25.05.2015','OH(3-1), 19.03.2015');
xlabel('\lambda/nm');
ylabel('normierte Intensitšt, a.u.');
grid on;
set(gca, 'FontSize', 22);
savefig('spektr.fig');
hold off;

end