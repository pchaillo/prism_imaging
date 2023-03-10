function bio_map_class = bio_class_builder3(scan,bio_num,class,color,deiso_tab,bio_ind,bio_map_class)

% TO FINISH with d_tab => montre les similarités
% il faut les exploiter mtn

%% Traitement des lignes fusionnées lors de classification (LDA)
s_ind = 0;

for i = 1 : length(scan.num)
    if scan.num(i) ~= scan.num_end
        for n = scan.num(i) : scan.num_end(i)
            s_ind = s_ind + 1 ;
            scan_list(s_ind,1) = i;
            scan_list(s_ind,2) = n;            
        end
    else
        s_ind = s_ind + 1;
        scan_list(s_ind,1) = i;
        scan_list(s_ind,2) = scan.num(i);
    end
end
    
    
%% Traitement des lignes fusionnés lors de la detection de peaks (cartographie)
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

%% Mise en lien les peaks de la carte et ceux de la LDA

% Points collatéraux
t_ind = 0;
for i = 1 : length(scan_list)
    % point collatéraux
    tab = find(scan_list(i,2) == deiso_list(:,1) );
    if ~isempty(tab)
        i
        if i == 756
            test = 0;
        end
        
        t_ind = t_ind + 1;
        d_tab(t_ind,1) = tab;
        d_tab(t_ind,2) = i;
        d_tab(t_ind,3) = deiso_list(tab,3);
        
        [x_b y_b] = find(d_tab(t_ind,3) == bio_ind);
        
        % if ~isempty(x_b) % inutile finalement
        ind_scan = scan_list(i,1);
        c_ind = find(string(scan.class(ind_scan)) == class);
        d_tab(t_ind,4) = c_ind;
        d_tab(t_ind,5) = x_b;
        d_tab(t_ind,6) = y_b ;
        
   end
end

si_d = size(d_tab);
si_c = size(class);

bio_num2 = abs(bio_num) ; % ne change rien

si = size(bio_ind);
%bio_map_class = zeros(si(1),si(2),3);
bio_map_class_coll = zeros(si(1),si(2),3);
bio_map_class_prin = zeros(si(1),si(2),3);

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

% Points principaux
for i = 1 : length(scan_list)
    [x_i y_i] = find(scan_list(i,2) == bio_num2);
%     i
%     d_i = find( i == d_tab(:,2))

    if ~isempty(x_i)
        scan_ind = scan_list(i,1);
        c_ind = find(string(scan.class(scan_ind)) == class)
        scan.class(scan_ind)
        color(c_ind,:)
        bio_map_class_prin(x_i,y_i,:) = color(c_ind,:); % principal
   % elseif  
        
    end
end

%% Replacement des classification sur les points
% Remets les informations dans le bon tableau et gère les priorités entre
% les poins principaux et collatéraux

% ne met pas de couleur si le point est detecté comme background
for i = 1 : si(1)
    for j = 1 : si(2)
        
        % point collatéraux
        if ~(bio_map_class_coll(i,j,1) == 0 && bio_map_class_coll(i,j,2) == 0 && bio_map_class_coll(i,j,3) == 0)
            if bio_num(i,j) > 0
                bio_map_class(i,j,:) = bio_map_class_coll(i,j,:);
                coll_flag = 1;
            else
                coll_flag = 0;
            end
        else
            coll_flag = 0;
        end
        
        %points principaux, ajoutés après (par dessus) car prioritaire
        if ~(bio_map_class_prin(i,j,1) == 0 && bio_map_class_prin(i,j,2) == 0 && bio_map_class_prin(i,j,3) == 0)
            if bio_num(i,j) > 0
                bio_map_class(i,j,:) = bio_map_class_prin(i,j,:);
                prin_flag = 1 ;
            else
                prin_flag = 0;
            end
        else
            prin_flag = 0;
        end
        
%         if prin_flag == 1 && coll_flag ==1
%             if ~(( bio_map_class_prin(i,j,1) == bio_map_class_coll(i,j,1) ) && (bio_map_class_prin(i,j,2) == bio_map_class_coll(i,j,2)) && (bio_map_class_prin(i,j,3) == bio_map_class_coll(i,j,3)))
%                 if bio_num(i,j) > 0
%                     X = sprintf('Attention, superposition des classes conflictuelle au pixel de coordonnées [%d,%d]',i,j);
%                     disp(X)
%                     bio_map_class(i,j,:) = 0.7;
%                 end
%             end
%         end

    end
end


% u = 101 ;

