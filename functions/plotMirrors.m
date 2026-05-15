function done = plotMirrors(irs)
% Create a new figure
figure;
% Plot the locations of the mirrors as dots
scatter3(irs.xt(:,1), irs.xt(:,2), irs.xt(:,3), 'filled');
hold on;

% Plot the normal vectors
scaleFactor = 0.1; % Adjust this value to change the length of the quivers
quiver3(irs.xt(:,1), irs.xt(:,2), irs.xt(:,3), irs.nt(:,1)*scaleFactor, irs.nt(:,2)*scaleFactor, irs.nt(:,3)*scaleFactor, 0);

title('Mirror Locations and their Normal Vectors');
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
axis equal; % To make sure the proportions are kept
grid on;
done = 1;
end