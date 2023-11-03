function [mapping_time_min, mapping_time_sec] = mapping_time_estimation(size_x,size_y,t_b,step_size,nb_shot)

nb_pixel_x = size_x/step_size;
nb_pixel_y = size_y/step_size;

nb_pixel = nb_pixel_x*nb_pixel_y ;

time_per_pixel = t_b + 0.2*nb_shot ;

mapping_time_s = nb_pixel*time_per_pixel ;

 mapping_time = mapping_time_s/60;

mapping_time_min = fix(mapping_time_s/60) ;  % integer part
 mapping_time_sec = rem(mapping_time_s,60) ;