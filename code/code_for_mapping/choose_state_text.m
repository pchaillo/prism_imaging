function state_text = choose_state_text(state_double)

n = state_double;

if n == 0
    state_text = 'Boot Fault';
elseif n == 1
    state_text = 'Warm up';
elseif n == 2
    state_text = 'Laser Ready for a RUN command';
elseif n == 3
    state_text = 'Flashing - Lamp disabled';
elseif n == 4
    state_text = 'Flashing awaiting shutter to be opened';
elseif n == 5
    state_text = 'Flashing - Pulse enabled';
elseif n == 6
    state_text = 'Pulsed Laser ON/NLO Warm up';
elseif n == 7
    state_text = 'Harmonic generator thermally stabilized';
elseif n == 8
    state_text = 'NLO Optimization';
elseif n == 9
    state_text = 'APM ok : NLO ready';
end

state_text = strcat('State : ',state_text);