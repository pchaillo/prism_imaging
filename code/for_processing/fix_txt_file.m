% This function adresses an unexpected behaviour in either mzML or imZML
% file generation, where two successive pixels with identical scan numbers
% will be conjoined into a single pixel, causing a shift of the entire
% image. The proper fix for this would be to rewrite our own mzML/imZML
% converter. For now, an interim solution was to detect duplicate pixels,
% and assign them scans that were not previously used in the mat file. This
% creates artifacts but preserved the shape of the image.

function fix_txt_file(txt_file)

l = length(pixels_scans);

fid = fopen(txt_file,'wt');
fprintf(fid, 'mzML=true\n');
fprintf(fid, 'zlib=false\n');
fprintf(fid, 'filter="scanNumber');

num = 0;

for i = 1 : l
    num = abs(pixels_scans(i).num);
    list(i) = num;
end

unique_scan_list = unique(list);
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

        ok = 0;
        while ok ~= 1
            test = find(unique_scan_list==new_num);
            if isempty(test) == 1
                ok = 1;
                unique_scan_list = [unique_scan_list, new_num];
            else
                new_num = new_num + 1 ;
            end
        end
    end

    fprintf(fid,' [%d,%d]',new_num,new_num);
    new_list(i) = new_num;
end

last_list = unique(new_list);

fclose(fid);

end