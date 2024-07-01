
txt = "recti_cont_rat_13_last.txt";

l = length(pixels_scans);

fid = fopen(txt,'wt');
fprintf(fid, 'mzML=true\n');
fprintf(fid, 'zlib=false\n');
fprintf(fid, 'filter="scanNumber');

num = 0;

for i = 1 : l
    num = abs(pixels_scans(i).num);
    list(i) = num;
end

list_u = unique(list);
num = 0;

for i = 1 : l +1
    i
    prev_num = num;
    if i < l
        num = abs(pixels_scans(i).num);
    else
        num = 16602;
    end

    if prev_num ~= num
        new_num = prev_num;
    else
        new_num = prev_num-1;
    end
    ok = 0;
    while ok ~= 1
        test = find(list_u==new_num);
        if isempty(test) == 1
            ok = 1;
            list_u = [list_u, new_num];
        else
            new_num = new_num + 1 ;
        end
    end

    fprintf(fid,' [%d,%d]',new_num,new_num);
    new_list(i) = new_num;
end

last_list = unique(new_list);

fclose(fid);