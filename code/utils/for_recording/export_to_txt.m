function export_to_txt(txt_path,num_list)

% Writing the txt file
file_id = fopen(txt_path,'wt'); % Those variables need better naming conventions
fprintf(file_id, 'mzML=true\n');
fprintf(file_id, 'zlib=false\n');
fprintf(file_id, 'filter="scanNumber');

l = length(num_list);

for i = 1 : l
    num = abs(num_list(i));
    fprintf(file_id,' [%d,%d]',num,num);
end

fprintf(file_id,'"');

fclose(file_id);

% The .txt file is generated as an intermediary file to generate the .mzML file