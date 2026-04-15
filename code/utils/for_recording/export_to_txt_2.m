function export_to_txt_2(txt_path,num_list)

% Writing the txt file
file_id = fopen(txt_path,'wt'); % Those variables need better naming conventions
fprintf(file_id, 'mzML=true\n');
fprintf(file_id, 'zlib=false\n');
fprintf(file_id, 'filter="scanNumber');

l = length(num_list);

for i = 1 : l
    num_min = num_list(i, 1);
    num_max = num_list(i, 2);
    fprintf(file_id,' [%d,%d]',num_min,num_max);
end

fprintf(file_id,'"');

fclose(file_id);

% The .txt file is generated as an intermediary file to generate the .mzML file

end