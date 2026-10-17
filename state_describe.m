num_rows = height(ML_Table);
all_sensors = unique(ML_Table.Sensor_ID)';
num_sensors = length(all_sensors);
num_files = num_rows / num_sensors; 
health_status = zeros(num_rows, 1);
baseline_limit = round(num_files * 0.10);

for s_idx_val = 1:num_sensors
    s_id = all_sensors(s_idx_val);
    sensor_mask = (ML_Table.Sensor_ID == s_id);
    sensor_rows = find(sensor_mask);
    kurt_raw = ML_Table.Kurtosis(sensor_mask);
    rms_raw  = ML_Table.RMS(sensor_mask);
    kurt_vals = movmean(kurt_raw, 15);
    rms_vals  = movmean(rms_raw, 15);
    base_kurt_mean = mean(kurt_vals(1:baseline_limit), 'omitnan');
    base_kurt_std  = std(kurt_vals(1:baseline_limit), 0, 'omitnan');
    base_rms_mean  = mean(rms_vals(1:baseline_limit), 'omitnan');
    base_rms_std   = std(rms_vals(1:baseline_limit), 0, 'omitnan');
    
    if base_kurt_std < 0.2, base_kurt_std = 0.2; 
    end
    
    if base_rms_std < 0.02, base_rms_std = 0.02; 
    end
    max_rms_end = max(rms_vals(round(num_files*0.75):end));
    is_damaged_bearing = (max_rms_end > (base_rms_mean + 6 * base_rms_std));
    
    for file_idx = 1:num_files
        row_idx = sensor_rows(file_idx);      
        if ~is_damaged_bearing
            status = 1;
        else
            curr_kurt = kurt_vals(file_idx);
            curr_rms  = rms_vals(file_idx);
            if curr_rms >= (base_rms_mean + 15 * base_rms_std) || curr_kurt >= (base_kurt_mean + 15 * base_kurt_std)
                status = 3; 
            elseif curr_rms >= (base_rms_mean + 6 * base_rms_std) || curr_kurt >= (base_kurt_mean + 8 * base_kurt_std)
                status = 2; 
            else
                status = 1;
            end
        end
        health_status(row_idx) = status;
    end
end

ML_Table.Health_State = health_status;
