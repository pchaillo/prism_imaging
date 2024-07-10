% This function adresses an unexpected behaviour in either mzML or imZML
% file generation, where two successive pixels with identical scan numbers
% will be conjoined into a single pixel, causing a shift of the entire
% image. The proper fix for this would be to rewrite our own mzML/imZML
% converter. For now, an interim solution was to detect duplicate pixels,
% and assign them scans that were not previously used in the mat file. This
% creates artifacts but preserved the shape of the image.

function fix_txt_file(txt_file, total_scan_number)

l = length(pixels_scans);

new_txt_file = fopen(txt_file,'wt');
fprintf(new_txt_file, 'mzML=true\n');
fprintf(new_txt_file, 'zlib=false\n');
fprintf(new_txt_file, 'filter="scanNumber');

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
        num = total_scan_number; 
    end

    if prev_num ~= num
        new_num = prev_num;
    else
        new_num = prev_num-1;

        duplicate_state = 0;  % 1: This number is unique. 0: This number is a duplicate
        while duplicate_state ~= 1
            test = find(unique_scan_list==new_num, 1);
            if isempty(test) == 1
                duplicate_state = 1;
                unique_scan_list = [unique_scan_list, new_num];
            else
                new_num = new_num + 1 ;
            end
        end
    end

    fprintf(new_txt_file,' [%d,%d]',new_num,new_num);
    new_list(i) = new_num;
end

last_list = unique(new_list);

fclose(new_txt_file);

end