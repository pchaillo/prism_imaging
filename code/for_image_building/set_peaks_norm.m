% Move to peak_selection function => intensity_selection

% Permet d'isoler la valeur utiles entre les bornes de masses d'ionisation
% qui ont été fixées

% system('set username');
function value = set_peaks_norm(limits,scan) % pick peak

disp("Fonction obsolete : utiliser intensity_selection ! (for_image_building) ")

% mxXML_on_map_norm7
%main_reconstruct

% bio_line = bio_dat(1);

peak_tab = scan.peaks.mz;

% e_tab = find(peak_tab(:,2) == 0); %already done 
% peak_tab(e_tab,:) = [];

v = 0;
l = length(peak_tab);

ind_m = find( peak_tab(:,1) <limits(2) );
ind_p = find( peak_tab(:,1) >limits(1) );

i_p = max(ind_m);
i_m = min(ind_p);

for i = i_m : i_p
    if peak_tab(i,1) > limits(1) &&  peak_tab(i,1) < limits(2)
        if peak_tab(i,2) > v
            v = peak_tab(i,2);
        end
    end
end

value = v;
