function bio_map_class = bio_class_builder(scan,bio_num,class,color,deiso_tab,bio_ind)

% TO FINISH with d_tab => montre les similarités
% il faut les exploiter mtn

d_ind = 0;
for i = 1 : length(deiso_tab)
    if length(deiso_tab{1,i}) ~= 1
        d_ind = d_ind + 1;
        deiso_clean(d_ind,1) = deiso_tab(i);
        deiso_clean(d_ind,2) = {i};
        
    end
end

l_ind = 0;
for i = 1 : length(deiso_clean)
    for j = 1 : length(deiso_clean{i,1})
        l_ind = l_ind + 1 ;
        deiso_list(l_ind,1) = deiso_clean{i,1}(j);
        deiso_list(l_ind,2) = i;
        deiso_list(l_ind,3) = deiso_clean{i,2};
    end
end

bio_num2 = abs(bio_num) ; % ne change rien

si = size(bio_ind);
bio_map_class = zeros(si(1),si(2),3);
bio_map_class_coll = zeros(si(1),si(2),3);
bio_map_class_prin = zeros(si(1),si(2),3);

t_ind = 0;
for i = 1 : length(scan.num)
    % point collatéraux
    tab = find(scan.num(i) == deiso_list(:,1) );
    if ~isempty(tab)
        t_ind = t_ind + 1;
        d_tab(t_ind,1) = tab;
        d_tab(t_ind,2) = i;
        d_tab(t_ind,3) = deiso_list(tab,3);
        
        [x_b y_b] = find(d_tab(t_ind,3) == bio_ind);
        
        % if ~isempty(x_b) % inutile finalement
        c_ind = find(string(scan.class(i)) == class);
        d_tab(t_ind,4) = c_ind;
        d_tab(t_ind,5) = x_b;
        d_tab(t_ind,6) = y_b ;
        
   %     bio_map_class_coll(x_b,y_b,:) = color(c_ind,:); % collateral
   % dans une nouvelle boucle for
        
        %             if c_ind == 2
        %                 [x_b                y_b]
        %             end
        %end
        
    end
end

si_d = size(d_tab);
si_c = size(class)

%gere les superposition de classe différent au sein d'un même pixel
c_tab = d_tab(1,4);
for i = 2 : si_d(1)
    if d_tab(i-1,2) == d_tab(i,2)
        c_tab(i) = d_tab(i,4);
    else
        for p = 1 : si_c(2)
            c_num = find(p == c_tab);
            c_tab_num(p) = length(c_num);
            m = max(c_tab_num);
            cc_ind = find(m == c_tab_num);
            if length(cc_ind)> 1 % priorité à la classe n1
                cc_ind = min(cc_ind);
            end
        end
        bio_map_class_coll(d_tab(i-1,5),d_tab(i-1,6),:) = color(cc_ind,:); 
    end
end

%points principaux
for i = 1 : length(scan.num)
    [x_i y_i] = find(scan.num(i) == bio_num2);
%     i
%     d_i = find( i == d_tab(:,2))

    if ~isempty(x_i)
        c_ind = find(string(scan.class(i)) == class);
        bio_map_class_prin(x_i,y_i,:) = color(c_ind,:); % principal
   % elseif  
        
    end
end


for i = 1 : si(1)
    for j = 1 : si(2)
        
        % point collatéraux
        if ~(bio_map_class_coll(i,j,1) == 0 && bio_map_class_coll(i,j,2) == 0 && bio_map_class_coll(i,j,3) == 0)
            bio_map_class(i,j,:) = bio_map_class_coll(i,j,:);
            coll_flag = 1;
        else
            coll_flag = 0;
        end
        
        %points principaux, ajoutés après (par dessus) car prioritaire
        if ~(bio_map_class_prin(i,j,1) == 0 && bio_map_class_prin(i,j,2) == 0 && bio_map_class_prin(i,j,3) == 0)
            bio_map_class(i,j,:) = bio_map_class_prin(i,j,:);
            prin_flag = 1 ;
        else
            prin_flag = 0;
        end
        
%         if i == 15 && j == 19
%             ganag = 0;
%         end
        
        if prin_flag == 1 && coll_flag ==1
            if ~(( bio_map_class_prin(i,j,1) == bio_map_class_coll(i,j,1) ) && (bio_map_class_prin(i,j,2) == bio_map_class_coll(i,j,2)) && (bio_map_class_prin(i,j,3) == bio_map_class_coll(i,j,3)))
                X = sprintf('Attention, superposition des classes conflictuelle au pixel de coordonnées [%d,%d]',i,j);
                disp(X)
                bio_map_class(i,j,:) = 0.5;
            end
        end
        
        %         if ((bio_map_class_prin(i,j,:) ~= [0 0 0]) && (bio_map_class_coll(i,j,:) ~= [0 0 0]))
        %             if bio_map_class_prin(i,j,:) ~= bio_map_class_coll(i,j,:)
        %                 X = sprintf('Attention, superposition des classes au pixel de coordonnées [%d,%d]',i,j);
        %                 disp(X)
        %             end
        %         end
    end
end


% u = 101 ;

