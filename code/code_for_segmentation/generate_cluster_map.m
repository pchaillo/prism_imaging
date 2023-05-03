function generate_cluster_map(x, y, mask_ini, idx, colormap_index)
    class_clusters = zeros(x*y, 1);
    class_clusters(mask_ini, 1) = idx;
    map = brewermap(colormap_index+1, 'paired');
    figure; imagesc(reshape(class_clusters, x, y)'); colormap(map); colorbar;
end