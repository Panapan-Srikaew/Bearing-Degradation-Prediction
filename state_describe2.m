num_rows = height(ML_Table);
num_sensors = 8;
num_files = num_rows / num_sensors; 
health_status = zeros(num_rows, 1);
row_counter = 1;

for file_idx = 1:num_files
    for s_idx = 1:num_sensors
        status = 1; 
        if s_idx <= 4          
            status = 1; 
        elseif s_idx == 5 || s_idx == 6           
            if file_idx >= 2100
                status = 3; 
            elseif file_idx >= 1400
                status = 2; 
            else
                status = 1; 
            end

        elseif s_idx == 7 || s_idx == 8
           
            if file_idx >= 1400
                status = 2; 
            else
                status = 1; 
            end
        end
        health_status(row_counter) = status;
        row_counter = row_counter + 1;
    end
end
ML_Table.Health_State = health_status;
