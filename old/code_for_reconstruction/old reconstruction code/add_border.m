% Ajoute des bords sans valeur pour ne pas perdre les informations aux
% extremités lors de l'affichage

function [ carte_x,carte_y,carte_z,bio_map  ] = add_border(carte_x,carte_y,carte_z,bio_map)

si = size(carte_x);

bio_map(:,si(2)+1) = NaN;
bio_map(si(1)+1,:) = NaN;

carte_z(:,si(2)+1) = carte_z(:,si(2));
carte_z(si(1)+1,:) = carte_z(si(1),:);

step = carte_x(2,1)-carte_x(1,1);

carte_x(:,si(2)+1) = carte_x(:,si(2));
carte_x(si(1)+1,:) = carte_x(si(1),:) + step;

carte_y(si(1)+1,:) = carte_y(si(1),:);
carte_y(:,si(2)+1) = carte_y(:,si(2)) + step;

end



