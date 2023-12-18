function reset_tcp(t)

%fopen(t);
data = ['ResetError' char(0)];
fwrite(t,data)
disp('reset error')
%fclose(t);
