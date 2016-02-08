function [] = gruppe2a_fpraktikum_reso(frames,partikel);

    close all

freqs = [4.997  7.022   9.033   10.93   13.05   15.05   17.04   18.04   19.04   20.04   21.04   22.03   23.02   25.01   27.00   29.11   31.00];

%     freqs = freqs(1:2:end);

amp = zeros(length(freqs),1);
amp_av = zeros(length(freqs),1);
n=2*partikel;
f = frames;
format = '.bmp';
name = '0-';

for t=1:17

    dir = num2str(t+2,'%01d');
    pathname = strcat('C:\Users\MELZER_C108\Documents\Sequences\Praktikum\20151216\JAI Side','\',dir);
    
        [h, l] = size(imread(strcat(pathname,'\','0-001.bmp')));
        l = l/3;

    C = int8(zeros(h,l));

        for k=1:f

            I = zeros(h,l);
            nstr = num2str(k,'%03d');
            fnamein = strcat(pathname,'\',name,nstr,format);
            I = imread(fnamein);
            B = int8(I(:,:,1));
            C = max(C, B);

        end

    x = zeros(n,1);
    y = zeros(n,1);
    
            figure;
            hold on;
            imshow(C);
            [x y] = ginput(n);
            close

    for i=1:2:n

        amp(i) = abs(y(i)-y(i+1));

    end

    amp_av(t) = sum(amp(:))/length(amp);
    clear amp C I B x y
    
end

amp_av = amp_av/max(amp_av(:));

    figure;
    hold on;
    grid on; grid minor;
    plot(freqs,amp_av,'-.xk','Linewidth',2);
    legend('Resonanzkurve');
    xlabel('Frequenz in Hz');
    ylabel('Amplitude, a.u.');
    axis([min(freqs) max(freqs) 0 1.05]);

end


