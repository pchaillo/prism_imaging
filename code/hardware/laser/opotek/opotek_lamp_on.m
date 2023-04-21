function  opotek_lamp_on(opotek)

%% ALLUME LA LAMPE

writeline(opotek, "STATE")
state = readline(opotek)
state_ok = readline(opotek);

pause(1)

%flush(opotek)
writeline(opotek, "RUN \r")
%writeline(opotek, "RUN")
run = readline(opotek)

pause(10)

if run == "ERROR"
    disp('the lamp cannot be turned on');
    is_ok = 0;
    %return
% else
%     disp('the lamp is on');
%     is_ok = 1;
%     % pause(10)
%     f = waitbar(0,'Please wait...');
%     pause(2)
%     
%     waitbar(.33,f,'The Lamp is turning on');
%     pause(4)
%     
%     waitbar(.67,f,'Just a moment');
%     pause(3)
%     
%     waitbar(1,f,' Ready for burst Mode ! ');
%     pause(1)
%     close(f)
end

% disp('the state should be 5');