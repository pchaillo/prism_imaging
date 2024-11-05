function answer = query(com, msg) % Quick way to debug the Radiant's connection 
    % if exist("laser_communication") == 0
    %     laser_communication = tcpclient('192.168.0.59', 10001);
    % end
    flush(com);
    writeline(com, msg)
    answer = readline(com);
end