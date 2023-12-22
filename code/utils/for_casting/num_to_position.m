%  Creates a table that links spatial data to temporal data

function index = num_to_position(map_name, mat) 

path(path, 'mat files')
path(path, 'map files')

% mat = 'M15_T2.mat' ; % debug only  #TODO
% map_name = 'M15_T2_corrected.map' ; % Debug only

mat_file = load(mat);
pixels_number = length(mat_file.bio_dat);

map = load_map_fcn(map_name); % Will be removable when nested in 
dimX = length(map.x);

num_order = zeros(1, pixels_number);
countdown = dimX;
for position = 1:pixels_number
    quotient = round(floor((position-1)/dimX));
    if mod(quotient, 2) == 0
        num_order(position) = mat_file.bio_dat(position).num;
    else
        disp(countdown)
        num_order(position) = mat_file.bio_dat(position + countdown - 1).num;
        countdown = countdown - 2;
        if countdown == -dimX
            countdown = dimX;
        end
    end
end

[~, index] = sort(abs(num_order)); % Order in which to pick molecular data sorted time-wise to reconstruct
                                   % spatial sorting

end