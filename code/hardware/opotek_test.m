function opotek_test()

    clear laser_communication lascom

    lascom = tcpclient('192.168.0.59', 10001);

    writeline(lascom, "ECHO 0")
    disp("ECHO 0")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);

    pause(0.1)
    writeline(lascom, "STATE")
    disp("STATE")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);
  
    temp_flag = 0;
    while temp_flag == 0
        writeline(lascom, "CGTEMP")
        pause(0.1)
        answer = char(readline(lascom));
        flush(lascom)
        temperature = str2double(answer(10:14));
        if temperature >= 38
            temp_flag = 1;
        else
            disp(temperature)
            pause(1)
        end
    end
    
    pause(0.1)
    writeline(lascom, "TRIG II")
    disp("TRIG II")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);

    pause(0.1)
    writeline(lascom, "CAPVSET 682")
    disp("CAPVSET 682")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);
    
    pause(1)
    writeline(lascom, "CAPVSET")
    disp("CAPVSET")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);

    pause(0.1)
    writeline(lascom, "RUN")
    disp("RUN")
    disp(readline(lascom));
    flush(lascom);
    
    pause(0.1)
    writeline(lascom, "QSW 1")
    disp("QSW 1")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);
    

    pause(3)
    writeline(lascom, "QSW 0")
    disp("QSW 0")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);

    pause(0.1)
    writeline(lascom, "STOP")
    disp("STOP")
    disp(readline(lascom));
    pause(0.1)
    flush(lascom);

end
