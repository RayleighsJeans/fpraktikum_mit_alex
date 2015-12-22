function [] = wigner_u_kalib

warning off
clear all
close all

radius = 7.1*1e-6;
alpha = 1./3;
ne = 0.7*1e15;
ni = 1./alpha*ne;
dichte0 = 1./0.61*ni;
e = 1.602*1e-19;
epsilon0 = 8.854*1e-12;
E1 = e./(epsilon0)*dichte0*(1-alpha);
rhod = 1514;
md = 4./(3)*pi*radius.^3*rhod;
kboltz = 1.380*1e-23;


% C = imread('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\kolloide\auswertung\daten\0-1.bmp');
% x1 = zeros(20,1);
% y1 = zeros(20,1);
% x2 = x1;
% y2 = y1;
% 
%     figure;
%     hold on;
%     imshow(C);
%     [x1 y1] = ginput(20);
%     close
% 
%     figure;
%     hold on;
%     imshow(C);
%     [x2 y2] = ginput(20);
%     close
% 
% kalibx = zeros(19,1);
% kaliby = kalibx;
% 
% for i=1:19
%     kalibx(i) = sqrt((x1(i)-x1(i+1)).^2+(y1(i)-y1(i+1)).^2);
%     kaliby(i) = sqrt((x2(i)-x2(i+1)).^2+(y2(i)-y2(i+1)).^2);
% end

% mean_p = (sum(kalibx(:))+sum(kaliby(:)))./(2*19);
mean_p = 43.013493295665214+[2 -2];
fac = 1./mean_p;
mean_v = 0.99;

    v_th_pf = fac.*mean_v;
    v_th_pf_err = fac.*([mean_v+0.68 mean_v-0.68]);
    
    %1 Frame dauert 1./59.9 Sekunden
    time = 59.999;
    
    v_th = v_th_pf.*time;
    v_th_err = v_th_pf_err.*time;
    
load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\kolloide\auswertung\fit_data');
% load('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\kolloide\auswertung\backup.mat');

fprintf(1,'Die mittlere thermische Geschwindigkeit ist %g mm/frame. \n',v_th_pf);
fprintf(1,'Die mittlere thermische Geschwindigkeit ist %g mm/s. \n',v_th);
fprintf(1,'Fehlerintervall\n');
disp(v_th_err);

A = imcomplement(imread('C:\Users\Philipp Hacker\Desktop\Uni\git\fpraktikum_mit_alex\kolloide\auswertung\daten\gruen00000.bmp'));

% mean_d = zeros(24,1);
% 
% for j=1:24
%     
% y3 = zeros(2,1);
% x3 = y3;
%     
%     figure;
%     hold on;
%     imshow(A(532:644,572:713));
%     set(gcf,'units','normalized','outerposition',[0 0 1 1])
%     [x3 y3] = ginput(2);
%     close
% 
%     mean_d_s(j) = sqrt((x3(1)-x3(2)).^2+(y3(1)-y3(2)).^2);
%     
% end
% 
% mean_d = sum(mean_d_s(:))./length(mean_d_s);
% wigner = sqrt(sqrt(3)./2)*mean_d*fac;

err = sqrt(sqrt(3)./2).*fac.*[2 -2];
wigner = 0.739374606173051+err;
% fprintf(1,'Der Wigner-Seitz-Radius ist %g mm\n',wigner);

param = 1e3*[2.280114720547424 0.126221547222896 0.017682060018220];

beta = param(3);
ome_res = param(2);
v_th = 1e-3*v_th;
wigner = 1e-3.*wigner;

T = v_th.^2.*pi.*md./(8.*kboltz);
T_ev = v_th.^2.*pi.*md./(8.*e);
Q = ome_res.^2.*md./E1;
Z = Q./e;
gamma = Q.^2./(4.*pi.*epsilon0.*wigner.*T.*kboltz);
gamma_eff = gamma.*exp(-wigner./(525.*1e-6));

% fprintf(1,'Resonanzfrequenz %g Hz\nKreisresoanzfreq. %g 1/s\nReibungskoeffizient %g s\nTemperatur %g K\nTemperatur %g eV\nLadung %g Coul\nLadungszahl %g\nKopplungsfaktor %g\nGamma effektiv %g \n', ome_res/(2.*pi), ome_res, beta, T, T_ev, Q, Z, gamma, gamma_eff);
% 
%     fprintf(1,'Feldstärke\n');
%     disp(E1);
%     fprintf(1,'Dichte n_i\n');
%     disp(dichte0);
%     fprintf(1,'Masse\n');
%     disp(md);
%     
% Idee!!!
lambdad = 525.*1e-6+[25.*1e-6 -25.*1e-6];
Te = lambdad.^2.*(0.61.*ne).*e.^2./(epsilon0.*kboltz);
q = 4.*pi.*epsilon0.*radius.*(1+radius./lambdad).*(-2*kboltz*Te./e);
gammat = q.^2./(4.*pi.*epsilon0.*wigner.*T.*kboltz);
gammat_eff = gamma.*exp(-wigner./(lambdad));
% disp(gamma);
% disp(gamma_eff);
% disp(Te);
% disp(q./(-e));

save('all.mat');
clear all
close all

end




    