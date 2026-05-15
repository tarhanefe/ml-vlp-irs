function predictedY = fitrKNN(trainX, trainY, testX, k)
    % Initialize the output prediction vector
    [trainX,mn,std] = standardize(trainX);
    testX = (testX-mn)./std;
    numTestSamples = size(testX, 1);
    predictedY = zeros(numTestSamples, 2);

    % Loop over all test samples
    for i = 1:numTestSamples
        % Calculate Euclidean distances between a test sample and all training samples
        distances = sqrt(sum((trainX - testX(i, :)).^2, 2));
        % Sort distances and get indices of k nearest neighbors
        [~, sortedIndices] = sort(distances);
        nearestNeighbors = sortedIndices(1:k);
        
        % Average the target values of the nearest neighbors
        predictedY(i,:) = mean(trainY(nearestNeighbors,:));
    end
end
