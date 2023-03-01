function tab_etal = load_etal_fcn(nom)
% Pour charger et afficher un étalonnage du capteur

out = load(nom)
%out = load('skin01.etal');

%si = size(out);

tab_etal = out';

% for i = 2 : si(1)
%     carte_x(i) = out(i,1);
%     carte_y(i) = out(i,2);
%     carte_z(i) = out(i,3);
% end

si = size(tab_etal);

figure()
hold on
for i = 1 : si(2)
    scatter(tab_etal(1,i),tab_etal(2,i))
end
xlabel('Hauteur de mesure, en mm')
ylabel('Décalage par rapport au centre, en pixels')

hold off