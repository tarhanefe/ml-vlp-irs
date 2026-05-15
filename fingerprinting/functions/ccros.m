function output = ccros(matrix1, matrix2)

% Separate the components of each matrix
x1 = matrix1(:,1);
y1 = matrix1(:,2);
z1 = matrix1(:,3);

x2 = matrix2(:,1);
y2 = matrix2(:,2);
z2 = matrix2(:,3);

% Compute the cross product components for all rows simultaneously
cx = y1.*z2 - z1.*y2;
cy = z1.*x2 - x1.*z2;
cz = x1.*y2 - y1.*x2;

% Concatenate the results
output = [cx, cy, cz];

end
