function output = plotRoomPower(power_map)
power_map_ = power_map(:, end:-1:1);
figure;
imagesc(power_map_);
colormap jet;
colorbar; % To show the color scale
xticks = 0:80:400;
yticks = 0:80:400;
set(gca, 'XTick', xticks, 'YTick',yticks);
set(gca, 'XTickLabel', {'0','0.8','1.6','2.4','3.2','4'}, 'YTickLabel', {'4','3.2','2.4','1.6','0.8','0'});
xlabel('X-axis (m)');
ylabel('Y-axis (m)');
title('2D Power Map of the Room with Uniform Mirror Orientation');

power_map = power_map';
figure;
surf(power_map);
shading interp; % Smooth shading
colormap jet;
colorbar; % To show the color scale
xticks = 0:80:400;
yticks = 0:80:400;
set(gca, 'XTick', xticks, 'YTick',yticks);
set(gca, 'XTickLabel', {'0','0.8','1.6','2.4','3.2','4'}, 'YTickLabel', {'0','0.8','1.6','2.4','3.2','4'});
title('3D Power Map of the Room with Uniform Mirror Orientation');
xlabel('X-axis (m)');
ylabel('Y-axis (m)');
zlabel('Watts');
output = 1;

end