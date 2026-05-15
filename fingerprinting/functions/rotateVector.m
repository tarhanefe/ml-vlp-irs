function rotated_vector = rotateVector(vector, axis, angle_degrees)
    % Rotate the given vector around the specified axis by the given angle (in degrees).
    % Inputs:
    %   vector: The input vector to be rotated.
    %   axis: The rotation axis ('x', 'y', or 'z').
    %   angle_degrees: The rotation angle in degrees.
    % Output:
    %   rotated_vector: The rotated vector.
    
    angle_radians = deg2rad(angle_degrees);
    
    if axis == 'x'
        rotation_matrix = [1, 0, 0; 0, cos(angle_radians), -sin(angle_radians); 0, sin(angle_radians), cos(angle_radians)];
    elseif axis == 'y'
        rotation_matrix = [cos(angle_radians), 0, sin(angle_radians); 0, 1, 0; -sin(angle_radians), 0, cos(angle_radians)];
    elseif axis == 'z'
        rotation_matrix = [cos(angle_radians), -sin(angle_radians), 0; sin(angle_radians), cos(angle_radians), 0; 0, 0, 1];
    else
        error('Invalid rotation axis. Use ''x'', ''y'', or ''z''.');
    end
    
    rotated_vector = rotation_matrix * vector';
    rotated_vector = rotated_vector';
end
