
function [Z, X, data1, data2, Mean_Image, ang_bin, rad_bin, mask, frames]=plasmaglw_anls(pathname,messungxy,name,format,angres,radres,nn,frequenz,fps)

tic

N = angres;

M = radres;

[height,length] = size(imread(strcat(pathname,'/',name,num2str(1,'%05i'),format)));

Z = zeros(height, length, 'double');

    for k = 1:1
        nstr=num2str(k,'%05i');
        fnamein=strcat(pathname,'/',name,nstr,format);
        Size = size(imread(fnamein));
        fprintf('Größe=%d %d\n', Size);
        Z = double(imread(fnamein));
    end
    
    
    fprintf(1,'Im folgenden Fenster wird die Maske der Intensitätsanalyse erstellt.\n Der erste Punkt definiert die Mitte, der zweite einen Punkt auf dem inneren Kreis \n und der dritte Punkt analog einen auf dem äußeren.\n');
    
    figure
    imagesc(imcomplement(Z));
    title('Erstellen der Maske für die Intensitätsanalyse','FontSize',12);
    [x,y]=ginput(3);

mid = [(x(1)),(y(1))];
rin = (sqrt((x(2)-x(1))^2+(y(1)-y(2))^2));
rout = (sqrt((x(3)-x(1))^2+(y(1)-y(3))^2));


fprintf('Mitte=%d %d\n', mid);

fprintf('r_in=%d\n', rin);

fprintf('r_out=%d\n', rout);

delta = zeros(length, height, 'double');

res_ang=2*pi/N;

res_rad=rout/M;


for i = 1:length
    
    for j = 1:height

        delta(i,j) = (sqrt(double((i-mid(1)).^2+(j-mid(2)).^2)));

    end

end

mask=(((delta.^2>rin.^2) & (delta.^2<rout.^2)));

delta2 = delta.*mask;

for i = 1:length
    
    for j = 1:height

        winkel(i,j)=(atan2(double(j-mid(2)),double(i-mid(1))));

        ang_bin(i,j)=floor(winkel(i,j)/res_ang)+N/2+1;
        
        rad_bin(i,j)=floor(delta2(i,j)/res_rad)+1;

    end

end

%keyboard

data = zeros(N,nn+1, 'double');

data2 = zeros(M,nn+1, 'double');

intens1=zeros(N,2, 'double');

intens2=zeros(M,2, 'double');

frames = floor(fps/frequenz)+1;

Mean_Image=zeros(length,height);

for k=2:frames+1
    
    nstr=num2str(k-1,'%05d');
    fnamein=strcat(pathname,'/',name,nstr,format);
    I = double(imcomplement(imread(fnamein)));
    Mean_Image=Mean_Image+I';
    
end

Mean_Image=Mean_Image/(frames+1);

for k = 2:nn

    disp(k)
    nstr=num2str(k-1,'%05d');
    fnamein=strcat(pathname,'/',name,nstr,format);
    I = double(imcomplement(imread(fnamein)));
    intens1=zeros(N,2);
    intens2=zeros(M,2);

    tmp = I'.*mask;
    
    for i = 1:length
        
        for j = 1:height

            if (tmp(i,j)>0);

                intens1(ang_bin(i,j),1)= intens1(ang_bin(i,j),1)+ (tmp(i,j)-Mean_Image(i,j));

                intens1(ang_bin(i,j),2)=intens1(ang_bin(i,j),2)+ 1;
                
                intens2(rad_bin(i,j),1)= intens2(rad_bin(i,j),1)+ (tmp(i,j)-Mean_Image(i,j));

                intens2(rad_bin(i,j),2)=intens2(rad_bin(i,j),2)+1;               

            else

            end
             
        end
        
       
    end
            
    data1(:,k) = intens1(:,1)./(intens1(:,2));
    
    data2(:,k) = intens2(:,1)./(intens2(:,2));
    
end

data1(:,nn+1) = 360*linspace(0,1,N);

data2(:,nn+1) = rout*linspace(0,1,M);

X = linspace(1,nn,nn);

Z = (Z'.*mask)';

%imagesc(X,data2(:,nn+1),data2(:,2:nn));

%imagesc(X,data1(:,nn+1),data1(:,2:nn));

save(sprintf('%s//%s_%s_output.mat',pathname,messungxy,name), 'Z', 'X', 'data1', 'data2', 'Mean_Image', 'ang_bin', 'rad_bin', 'mask', 'frames');

toc

clear

end