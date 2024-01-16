% FR : Permet d'isoler la valeur utiles entre les bornes de masses d'ionisation qui ont été fixées
% ENG : Function to select the maximal intensity between the choosen limits values

function value = intensity_selection(limits,scan) % change the name for intensity_selection ?

peak_array = scan.peaks.mz;

value = 0;
l = length(peak_array);

minimal_indices_list = find( peak_array(:,1) < limits(2) );
maximal_indices_list = find( peak_array(:,1) > limits(1) );

minimal_indice = max(minimal_indices_list);
maximal_indice = min(maximal_indices_list);

for i = maximal_indice : minimal_indice
    if peak_array(i,1) > limits(1) &&  peak_array(i,1) < limits(2)
        if peak_array(i,2) > value
            value = peak_array(i,2);
        end
    end
end
