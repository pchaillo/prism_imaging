function output = queryUSB(com, msg)
    flush(com)
    writeline(com, msg)
    pause(0.1)
    output = read(com, 16, "string");
end