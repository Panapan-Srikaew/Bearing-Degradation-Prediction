folder_path = "C:\chula\project ML\Bearing test Project\bearimg data\archive\1st_test\1st_test"; 
all_items = dir(folder_path);
valid_files = all_items(~[all_items.isdir]);
num_files = length(valid_files);
master_data_matrix = []; 
for file_idx = 1:num_files
    file_path = fullfile(folder_path, valid_files(file_idx).name);
    table_1 = readmatrix(file_path, 'FileType', 'text');
    num_channels = size(table_1, 2);
    if num_channels == 0
        continue;
    end
    for sensor_idx = 1:num_channels
        channel_data = table_1(:, sensor_idx);
        m_val  = mean(channel_data, 'all', 'omitnan');
        s_val  = std(channel_data, 0, 'all', 'omitnan');
        r_val  = rms(channel_data, 'all');
        mx_val = max(abs(channel_data), [], 'all');
        k_val  = kurtosis(channel_data(:));
        row_vector = [m_val, s_val, r_val, mx_val, k_val, sensor_idx];
        master_data_matrix = [master_data_matrix; row_vector];
    end
end
stat_names = {'Mean', 'Std', 'RMS', 'Max', 'Kurtosis', 'Sensor_ID'};
ML_Table = array2table(master_data_matrix, 'VariableNames', stat_names);