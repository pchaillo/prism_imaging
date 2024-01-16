% Ajoute des bords sans valeur pour ne pas perdre les informations aux
% extremités lors de l'affichage

% add_border_3()

function [ carte_x,carte_y,carte_z,bio_map  ] = fix_border(carte_x,carte_y,carte_z,bio_map,bio_ind)

si = size(carte_x);

ligne_ind  = bio_ind(1,1:end-1);
ligne_u = unique(ligne_ind);

nb_pt = length(ligne_ind)/length(ligne_u);

step = carte_x(2,1)-carte_x(1,1);

i = 0;

nb_add = nb_pt - 1 ;

% if nb_pt == 1
%     nb_add = 0;
%     nb_supp = 0;
% elseif nb_pt == 2
%     nb_add = 1;
%     nb_supp = 0;
% elseif nb_pt == 3
%     nb_add = 1;
%     nb_supp = 1;
% elseif nb_pt == 4
%     nb_add = 0;
%     nb_supp = 1;
% elseif nb_pt > 4
%     nb_supp = floor((nb_pt-1)/2);
%     nb_add = nb_supp-1;
% end

if nb_add ~= 0
    for i = 1 : nb_add
        
        bio_map(:,si(2)+i) = bio_map(:,si(2));
        bio_map(si(1)+i,:) = bio_map(si(1),:);
        
        carte_z(:,si(2)+i) = carte_z(:,si(2));
        carte_z(si(1)+i,:) = carte_z(si(1),:);
        
        
        carte_x(:,si(2)+i) = carte_x(:,si(2));
        carte_x(si(1)+i,:) = carte_x(si(1),:) + step*i;
        
        carte_y(si(1)+i,:) = carte_y(si(1),:);
        carte_y(:,si(2)+i) = carte_y(:,si(2)) + step*i;
        
    end
end


%%% Ajout de la bordure pour l'affichage
i = i + 1;

bio_map(:,si(2)+i) = NaN;
bio_map(si(1)+i,:) = NaN;

carte_z(:,si(2)+i) = carte_z(:,si(2));
carte_z(si(1)+i,:) = carte_z(si(1),:);


carte_x(:,si(2)+i) = carte_x(:,si(2));
carte_x(si(1)+i,:) = carte_x(si(1),:) + step*i;

carte_y(si(1)+i,:) = carte_y(si(1),:);
carte_y(:,si(2)+i) = carte_y(:,si(2)) + step*i;

%%% Supression des lignes pour égaliser les tailles des pixels

%%% Plus utile avec polynomial_interpolaton2()
% 
% bio_map(:,1:nb_supp) = [];
% bio_map(1:nb_supp,:) = [];
% 
% carte_z(:,1:nb_supp) = [];
% carte_z(1:nb_supp,:) = [];
% 
% carte_x(:,1:nb_supp) = [];
% carte_x(1:nb_supp,:) = [];
% 
% carte_y(1:nb_supp,:) = [];
% carte_y(:,1:nb_supp) = [];

