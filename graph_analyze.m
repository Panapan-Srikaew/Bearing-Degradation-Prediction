figure('Name', 'All Sensors Feature Trends Comparison', 'Color', 'w', 'Position', [50, 50, 1400, 900]);
features_to_plot = {'Mean', 'Std', 'RMS', 'Max', 'Kurtosis'};
all_sensors = unique(ML_Table.Sensor_ID)'; 
num_sensors = length(all_sensors);
sensor_colors = lines(num_sensors); 
time_axis = (1:sum(ML_Table.Sensor_ID == all_sensors(1)))';

for i = 1:length(features_to_plot)
    subplot(3, 2, i);
    hold on;    
    legend_labels = cell(num_sensors, 1);    
    
    for idx = 1:num_sensors
        s_idx = all_sensors(idx);
        sensor_mask = (ML_Table.Sensor_ID == s_idx);
        sensor_data = ML_Table(sensor_mask, features_to_plot{i});        
        plot(time_axis, sensor_data{:,1}, 'Color', sensor_colors(idx, :), 'LineWidth', 1.2);
        legend_labels{idx} = ['Sensor ', num2str(s_idx)];
    end
    
    grid on;
    hold off;
    ax = gca;
    ax.Color = 'w';                 
    ax.XColor = 'k';                 
    ax.YColor = 'k';                 
    ax.GridColor = [0.7 0.7 0.7];   
    ax.GridAlpha = 0.5;
    title(['Feature Comparison: ', features_to_plot{i}], 'Color', 'k', 'FontSize', 10, 'FontWeight', 'bold');
    xlabel('File Index (Time)', 'Color', 'k', 'FontSize', 9);
    ylabel('Value', 'Color', 'k', 'FontSize', 9);
    lgd = legend(legend_labels, 'Location', 'bestoutside', 'Interpreter', 'none', 'FontSize', 7);
    lgd.TextColor = 'k';
    lgd.Color = 'w';
    lgd.EdgeColor = [0.8 0.8 0.8];
end
sgtitle('All Sensors Feature Trend Comparison (Dynamic)', 'Color', 'k', 'FontSize', 14, 'FontWeight', 'bold');