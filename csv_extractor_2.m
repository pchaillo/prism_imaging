clear all
close all
clc

% Version sans bining => fonctionne

path(path,"code/code_for_analysing");
path(path,"code/code_for_recording");
path(path,"mat files");
path(path,"mzXML files");


carte = load_map4_fcn("m_b.map");

load("m_b.mat");

l = length(bio_dat); % useless

% win = 0.1;
% band = [100 1500];

% peak_tab = bio_dat(1).peaks.mz;
% peak_tab_clean = bining_2(peak_tab,win,band);
% mz_ind_tab = peak_tab_clean(:,1)';
% l = length(mz_ind_tab);

% mzXML = mzxmlread("2021_15_09_m_b.mzXML");

% tab(1,6:6+l-1) = mz_ind_tab;

dim = size(carte.x);
u = 1;

for j = 1: 1 : dim(1) 
    for k = 1 : dim(2)
        u = u +1
        tab(u,1) = carte.x(j,k);
        tab(u,2) = carte.y(j,k);
        tab(u,3) = carte.z(j,k);
        tab(u,4) = carte.time(j,k);
        tab(u,5) = bio_dat(u-1).totIonCurrent; % -1 pcq la 1ère ligne est prise pour mettre les indices des rapports mz
        peak_tab = bio_dat(u-1).peaks.mz;
        peak_tab_clean_line = put_tab_on_line(peak_tab);
        l = length(peak_tab_clean_line);
        tab(u,6:6+l-1) = peak_tab_clean_line;
    end
end

csvwrite("msi_data3o.csv",tab')

cell = num2cell(tab');
cell{1,1} = "x";
cell{2,1} = "y";
cell{3,1} = "z";
cell{4,1} = "time";
cell{5,1} = "totIonCurrent";
T = cell2table(cell);
writetable(T,"msi_data_test3a.csv")