% Ajoute des points nuls quand il n'y a pas de pic pdt trop longtemps +
% correction des décalages

function [bio_dat, time,g] = load_mzXML_0bis(mzXMLStruct)

% ajout de points + suppression des décalages

file = mzXMLStruct.scan ;

l = length(file);

nb_p = 1114 ; % number of exepcted point
t_step = 3.05 ; % time in second between two measure
t_t = 1.2 ; % time tolerance

threshold_begin = 300000;

ok = 0 ;

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
t_f_r = 55.39+0.1;
t_f = t_f_r*60; %final time in second

k = 0;

diff = 0;
g = 0;

d = 0;
e_p_tab(1) = 0;

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
        k = k + 1;
        bio_dat(k) = file(1);
        %t_r = file(1).retentionTime;
        %t = raw_to_time(t_r);
        d = d +1 ;
        e_p_tab(d) = k;
    end
    
    %     %%% delete empty point to avoid the shift
    time(k) = t;
    if k > 1
        delta = time(k) - time(k-1) - t_step;
        diff = diff + delta;
        if diff > t_step%*0.7
            %  k = k - 1;
            %time(k) = t;
            %  bio_dat(k) = file(1);
            %  diff = diff - t_step;
            diff = 0;
            g = g + 1;
           % if e_p_tab(1) ~= 0 %
                
                e_k = e_p_tab(length(e_p_tab));
                bio_dat(e_k).num = 2;
                bio_dat(e_k).totIonCurrent = 0;
%             else  % à tester
%                 bio_dat(k).num = 2;
%                 bio_dat(k).totIonCurrent = 0;
%             end
        end
        
    end
%     %     %%%
    
    t = t + t_step;
    if t > t_f
        scrut = 0;
    end
end
