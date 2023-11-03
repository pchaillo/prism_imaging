
 function tab_out2 = fusion_p2(tab_in)
 
 % fusion part 2
 %fusionne toutes les infos de courant d'ionisation pour finir la fusion
 
ind_dec = 0 ;
for i = 1 : length(tab_in)-1
    if tab_in(i,1) > tab_in(i+1,1)
        ind_dec = i ;
    end
end

l1 = tab_in(1:ind_dec,:);
l2 = tab_in( ind_dec+1:length(tab_in),: );
 
[C,I] = sort([l1(:,1)',l2(:,1)']);

for i = 1 : length(I)
    if I(i) > length(l1)
        D(i) = l2(I(i) - length(l1),2);
    else
        D(i) =  l1(I(i),2);
    end
end



tab_out2 = [ C ; D]';