
function pixels_scans_processed = preprocess_all_image(app, pixels_scans, win)

l = length(pixels_scans);
fprintf('(%s) - Preprocessing data \n', datestr(now,'HH:MM:SS'));
for i = 1 : l
%     tic % for time comsumption estimation
    pixels_scans_processed(i) = preprocess(app, pixels_scans(i),win); % pixels_scans_processed
    X = sprintf('Preprocessing : %d / %d',i,l);
    disp(X)
    % update_log(app, X) % Slow too much preprocessing => print only at the
    % preprocessing

%     toc
end