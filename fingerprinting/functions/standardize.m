function [standardizedX,meanX,stdX] = standardize(X)
    % Standardize the dataset X.
    %
    % Args:
    % X: The data to be standardized, assumed to be a matrix with 
    %    rows as samples and columns as features.
    %
    % Returns:
    % standardizedX: The standardized data.

    % Calculate mean and standard deviation for each feature (column)
    meanX = mean(X);
    stdX = std(X);
    
    % Avoid division by zero for constant features
    stdX(stdX == 0) = 1;
    
    % Standardize each feature (column)
    standardizedX = (X - meanX) ./ stdX;
end
