function final_table = file2feature(table_1, num_channels)
    
    stat_type = {'Mean'; 'Std'; 'RMS'; 'Peak'; 'Kurtosis'};
    all_data = zeros(5, num_channels);
    for i = 1:num_channels
        [meanVal, stdVal, rmsVal, maxVal, kurtosisVal] = feature_extract(table_1, i);
        all_data(:, i) = [meanVal, stdVal, rmsVal, maxVal, kurtosisVal];
    end
    final_table = table(stat_type);
    for i = 1:num_channels
        col_name = ['Ch_', num2str(i)]; 
        final_table.(col_name) = all_data(:, i);
    end
end