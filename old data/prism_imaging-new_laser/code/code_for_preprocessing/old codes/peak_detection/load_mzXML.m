<<<<<<< HEAD
% Première version de load_mzXML
% permet de choisir les valeurs de pic, sans fct find_peak()

function [bio_dat, time, g] = load_mzXML(mzXMLStruct)

file = mzXMLStruct.scan ;

l = length(file);

%nb_p = 400 ; % number of expected points
t_step = 3; % time in second between two measure
t_t = 1.4; % time tolerance

threshold_begin = 80000;

ok = 0;

g = 0;

%for i = 1 : l
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        i_d = i;
        ok = 1;
    end
end

t_d_r = file(i_d).retentionTime;
t_d = raw_to_time(t_d_r);

% t_f_r = file(l).retentionTime;
% t_f = +0.1;

t_f_r = 31.61+0.1; %This value = Nb(x pixels)* Nb(y pixels) * 3 (sec/pixel) / 60 + FirstShotScanNumer (minutes)
t_f = t_f_r*60; %final time in secondavec

% t_f = 55.39;

k = 0;

nb_fail = 0;
scrut = 1;

%for t = t_d : t_step : t_f
t = t_d;
while scrut == 1
    ion_max = 0;
    i_max = 0;
    for i = i_d : l
        t_i_r = file(i).retentionTime;
        t_i = raw_to_time(t_i_r);
        if t_i > t - t_t && t_i < t + t_t
            if file(i).totIonCurrent > ion_max
                ion_max = file(i).totIonCurrent;
                i_max = i;
            end
        end
    end
    if i_max ~= 0
        k = k + 1;
        bio_dat(k) = file(i_max); 
        t_r = file(i_max).retentionTime;
        t = raw_to_time(t_r);
    else 
        nb_fail = nb_fail + 1;
    end
    time (k) = t;
    t = t + t_step;
    if t > t_f
        scrut = 0;
    end
end
=======
% Première version de load_mzXML
% permet de choisir les valeurs de pic, sans fct find_peak()

function [bio_dat, time, g] = load_mzXML(mzXMLStruct)

file = mzXMLStruct.scan ;

l = length(file);

%nb_p = 400 ; % number of expected points
t_step = 3; % time in second between two measure
t_t = 1.4; % time tolerance

threshold_begin = 80000;

ok = 0;

g = 0;

%for i = 1 : l
i = 0;
while ok == 0
    i = i + 1;
    if file(i).totIonCurrent > threshold_begin
        i_d = i;
        ok = 1;
    end
end

t_d_r = file(i_d).retentionTime;
t_d = raw_to_time(t_d_r);

% t_f_r = file(l).retentionTime;
% t_f = +0.1;

t_f_r = 31.61+0.1; %This value = Nb(x pixels)* Nb(y pixels) * 3 (sec/pixel) / 60 + FirstShotScanNumer (minutes)
t_f = t_f_r*60; %final time in secondavec

% t_f = 55.39;

k = 0;

nb_fail = 0;
scrut = 1;

%for t = t_d : t_step : t_f
t = t_d;
while scrut == 1
    ion_max = 0;
    i_max = 0;
    for i = i_d : l
        t_i_r = file(i).retentionTime;
        t_i = raw_to_time(t_i_r);
        if t_i > t - t_t && t_i < t + t_t
            if file(i).totIonCurrent > ion_max
                ion_max = file(i).totIonCurrent;
                i_max = i;
            end
        end
    end
    if i_max ~= 0
        k = k + 1;
        bio_dat(k) = file(i_max); 
        t_r = file(i_max).retentionTime;
        t = raw_to_time(t_r);
    else 
        nb_fail = nb_fail + 1;
    end
    time (k) = t;
    t = t + t_step;
    if t > t_f
        scrut = 0;
    end
end
>>>>>>> prism_copy_for_tests
