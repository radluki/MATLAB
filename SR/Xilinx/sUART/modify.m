file = fopen('data.txt');
fileo = fopen('data_matlab.txt','w+');
if file && fileo
    line = fgets(file);
    while line~=-1
        for i = line
            i
            znak = (fliplr(dec2bin(i,8)))
            fwrite(fileo,['001' znak '0 ']);
        end
        line = fgets(file);
    end
    
else
    printf('%d %d',file,fileo);
end
fclose(file);
fclose(fileo);
