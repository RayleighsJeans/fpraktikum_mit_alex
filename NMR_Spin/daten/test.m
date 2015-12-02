function test
[fid] = fopen("NewFile2.csv","r","native");
kopfzeile = fgetl(fid);
[t,U] = fscanf(fid, "%f;%f")