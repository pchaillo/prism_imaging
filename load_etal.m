
% Pour charger et afficher un étalonnage du capteur

out = load('skin01.etal');

tab_etal = out';

si = size(tab_etal);

figure()
hold on
for i = 1 : si(2)
    scatter(tab_etal(1,i),tab_etal(2,i))
end
xlabel('Hauteur de mesure, en mm')
ylabel('Décalage par rapport au centre, en pixels')
hold off