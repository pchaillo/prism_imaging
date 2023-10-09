function tab_line = put_tab_on_line(tab)

% Changement de la forme du tableau ( (l/2)x2 => lx1 )

% Attention, cette opération est effectuée dans l'autre sens dans la
% fonction preprocess6 => il serait plus efficace, dans l'absolu, de ne pas
% faire cette conversion dans les deux sens mais de ne pas la faire ou la
% faire à un autre moment (utilisation ? Est-il plus perfomant de refaire
% la mise en forme du tableau ou de l'enregistrerà chaque fois ?)

%% Code dans preprocess6
% h = 0; % remise du tableau dans la bonne forme ( lx1 par (l/2)x2 )
% for i = 1 : l
%     if ( mod(i,2) == 0 )
%         peak_tab(h,2) = peak_tab_r(i);
%     else
%         h = h + 1;
%         peak_tab(h,1) = peak_tab_r(i);
%     end
% end

%% Code de la fonction
si = size(tab);
u = 0;
for i = 1 : 1 : si(1)
    u = u + 1;
    tab_line(u) = tab(i,1);
    u = u + 1;
    tab_line(u) = tab(i,2);
end