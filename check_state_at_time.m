figure('Name', 'Health State Timeline Comparison', 'Color', 'w', 'Position', [100, 100, 1200, 600]);
hold on;
all_sensors = unique(ML_Table.Sensor_ID)';
num_sensors = length(all_sensors);
sensor_colors = lines(num_sensors); 
time_axis = (1:sum(ML_Table.Sensor_ID == all_sensors(1)))';
legend_labels = cell(num_sensors, 1);
for idx = 1:num_sensors
    s_idx = all_sensors(idx);
    sensor_mask = (ML_Table.Sensor_ID == s_idx);
    state_data = ML_Table.Health_State(sensor_mask);
    stairs(time_axis, state_data, 'Color', sensor_colors(idx, :), 'LineWidth', 1.5);
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


yticks([1, 2, 3]);
yticklabels({'1: Normal', '2: Warning', '3: Critical'});
ylim([0.5, 3.5]);


title('Bearing Health State Transition Timeline Across Sensors', 'Color', 'k', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('File Index (Time)', 'Color', 'k', 'FontSize', 10);
ylabel('Health State', 'Color', 'k', 'FontSize', 10);


lgd = legend(legend_labels, 'Location', 'eastoutside', 'Interpreter', 'none', 'FontSize', 9);
lgd.TextColor = 'k';
lgd.Color = 'w';
lgd.EdgeColor = [0.8 0.8 0.8];