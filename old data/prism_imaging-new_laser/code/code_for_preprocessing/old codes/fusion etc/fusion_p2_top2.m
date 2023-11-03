function tab_out2 = fusion_p2_top2(tab_in)

% fusion part 2
%fusionne toutes les infos de courant d'ionisation pour finir la fusion

[C,I] = sort(tab_in(:,1));

D = tab_in(I,2);

tab_out2 = [ C' ; D']';

for i = 1 : length(tab_out2)-1 % verification de la fusion des spectres
    if tab_out2(i,1) > tab_out2(i+1,1)
        disp('attention pb de fusion');
    end
end