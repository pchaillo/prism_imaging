function real_voltage = set_voltage(voltage_value,opotek)

%% set the voltage
writeline(opotek, "CAPVSET"); % CAPVSET ### program the flashlamp voltage
capvset = readline(opotek);
update_log(app, capvset)
capvset_ok = readline(opotek);
update_log(app, capvset_ok)

str_volt = num2str(voltage_value);
to_set_temp = strcat("CAPVSET ",str_volt);

writeline(opotek, to_set_temp) % CAPVSET ### program the flashlamp voltage
%capvset2 = readline(opotek)
capvset_ok2 = readline(opotek);
update_log(app, capvset_ok2)

writeline(opotek, "CAPVSET") % CAPVSET ### program the flashlamp voltage
capvset3 = readline(opotek);
update_log(app, capvset3)
capvset_ok3 = readline(opotek);
update_log(app, capvset_ok3)

real_volt_char = convertStringsToChars(capvset3);
l = length(real_volt_char);
real_voltage_str = real_volt_char(l-2:l);
real_voltage = str2double(real_voltage_str);

if real_voltage ~= voltage_value
    update_log(app, 'Warning: Problem found with the voltage setting.');
    return
    
end