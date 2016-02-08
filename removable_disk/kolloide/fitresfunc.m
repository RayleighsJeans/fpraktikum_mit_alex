% array= [5*2*pi 3.32 ; 8*2*pi 3.925; 11*2*pi 5.96; 12*pi*2 7.39; 13*2*pi 8.71;14*2*pi 12.405;15*2*pi 17.0457;16*2*pi 15.24;17*2*pi 10.6285; 18*2*pi 6.99; 21*2*pi 4.67; 24*2*pi 3.49; 27*2*pi 2.92;30*2*pi 2.77];
% save array;
% omega= array(:, 1);
% data= array(:, 2);


opts=optimset('lsqnonlin');
opts=optimset(opts, 'Display', 'none');

param0=[50000 2*pi*15 30];
lo=[0 0 0];
hi=[100000 2*pi*50 100];

param=zeros(3, 1);
param=lsqnonlin(@resfunc, param0, lo, hi, opts, omega, data);

hold on;
plot(omega, data, 'bx', 'LineWidth', 2);
plot(omega, resfunc(param, omega, 0), 'r', 'LineWidth', 2);
hold off;

