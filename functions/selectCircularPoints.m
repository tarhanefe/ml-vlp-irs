function points = selectCircularPoints(N,loc,r)
    %Parameters 
    % N: Number of points 
    % loc: Location of the center of the points
    % r: Distance of the points from the center
    % height: Height of the 2D circulant grid of the points
    x0 = loc(1);
    y0 = loc(2);

    % Angles at which to place the points (evenly spaced from 0 to 2*pi)
    theta = linspace(0, 2*pi, N+1);
    theta(end) = []; % Remove the last point to avoid duplicating the first one
    
    % Calculate the coordinates of the points
    x = x0 + r * cos(theta);
    y = y0 + r * sin(theta);

    points = [x' y'];

    % Assuming points matrix is already obtained from selectCircularPoints function
    % Example: points = selectCircularPoints(N, [x0, y0], r, height);
    
    % Extract individual coordinates for plotting
    x = points(:, 1);
    y = points(:, 2);
    
    % % Plotting the circular points in 3D
    % figure;
    % plot(x, y,'ro'); % Plot points as red circles
    % hold on;
    % 
    % % Generating and plotting the circle in 3D at the specified height
    % theta = linspace(0, 2*pi, 100); % Smooth circle
    % circle_x = x0 + r * cos(theta); % Using the first point's x for center
    % circle_y = y0 + r * sin(theta); % Using the first point's y for center
    % plot(circle_x, circle_y, 'b-'); % Plot circle as a blue line
    % 
    % % Enhancements for better visualization
    % grid on; % Enable grid
    % xlabel('X');
    % ylabel('Y');
    % title('Visualization of Circular Points');
    % axis equal; % Equal scaling for all axes
    % 
    % % Check if we need to display the plot
    % if disp == "on"
    %     % The plotting commands above will execute
    % else
    %     hold off; % In case disp is not "on", ensure no more plotting
    % end
  
