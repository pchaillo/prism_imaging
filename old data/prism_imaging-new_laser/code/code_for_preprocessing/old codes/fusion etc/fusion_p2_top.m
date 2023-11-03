function tab_out2 = fusion_p2_top(tab_in,nb_line)

% fusion part 2
%fusionne toutes les infos de courant d'ionisation pour finir la fusion

[C,I] = sort(tab_in(:,1));

D = tab_in(I,2);

tab_out2 = [ C' ; D']';

si = size(tab_out2);

for i = 1 : si(1)-1 % verification de la fusion des spectres
    if tab_out2(i,1) > tab_out2(i+1,1)
        disp('attention pb de fusion');
    end
end