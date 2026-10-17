selected_features = {'Std', 'RMS', 'Max', 'Kurtosis', 'Sensor_ID', 'Health_State'};
ML_Table_Optimized = ML_Table(:, selected_features);
disp(head(ML_Table_Optimized, 5));