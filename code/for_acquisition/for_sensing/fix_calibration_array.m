function corrected_calibration_array = fix_calibration_array(app, calibration_array)

% Removes erroneous values
% New version for the ILD1320-25 sensor

supp = 1 ;
stop = 0 ;
f =  length(calibration_array)-1 ; % Why "f"?
c_sup = 0;
while supp ~= 0
    supp = 0;
    f = length(calibration_array)-1;
    
    while stop == 0
        
        if f == 2
            stop = 1;
        end
        
        if f >= length(calibration_array)
            f = length(calibration_array)-1;
        end
        
        if abs(calibration_array(2,f+1)) < abs(calibration_array(2,f) )
            calibration_array(:,f+1) = [];
            supp = supp + 1;
        else
            f = f - 1;
        end
        
    end
    c_sup = c_sup +1 ;
    supp_array(c_sup) = supp;
end

deleted_value_numer = sum(supp_array);
update_log(app, string(deleted_value_numer))

to_supp = -1;

if deleted_value_numer > 100
    update_log(app, 'Warning: Biased table');
end

for i = 1 :  length(calibration_array) % Corrects sensible values that are wrong nonetheless
    if calibration_array(2,i) <0.8
        to_supp = [to_supp i];
    end
end

to_supp(1) = []; % Removes the initial -1 offset

calibration_array(:,to_supp) = [];

corrected_calibration_array = calibration_array;