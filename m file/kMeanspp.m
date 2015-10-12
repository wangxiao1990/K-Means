function [estimatedLabels, estimatedMeans, MSE] = kMeanspp(inputData, numberOfClusters, stopTolerance, numberOfRuns)
% The implementation MUST be a function that takes the following inputs:
% i. inputData: nSamples x dDimensions array with the data to be clustered
% ii. numberOfClusters: number of cluster for algorithm
% iii. stopTolerance: convergence criteria
% iv. numberOfRuns: number of times the algorithm will run with random initializations
% The function should output the results for the run that gave minimum MSE. The outputs should be:
% i. estimatedLabels: nSamples x 1 vector with estimated cluster assignment
% ii. estimatedMeans: numberOfClusters x dDimensions array with the estimated cluster means
% iii. MSE: nIterations x 1 vector with MSE as a function of iteration number

n = size(inputData,1);
if size(inputData,2) > 2
    d = size(inputData,2) - 1;
else d = size(inputData,2);
end
estimatedLabels = zeros(n,1);
estimatedMeans = zeros(numberOfClusters, d);

newMeans = zeros(numberOfClusters, d);
oldMeans = zeros(numberOfClusters, d);
for i = 1:numberOfRuns
    probability = ones(1,n)/n;
    for j = 1:numberOfClusters
        oldMeans(j,1:d) = inf;
        newMeans(j,1:d) = inputData(randsrc(1,1,[(1:n); probability]),1:d);
        dx = pdist2(inputData(:,1:d),newMeans(1:j,1:d)).^2;
        Dx = min(dx,[],2);
        probability = Dx'/sum(Dx);
    end
    
    iteration = 0;
    while max(abs(newMeans - oldMeans)) > stopTolerance
        iteration = iteration + 1;
        dist = pdist2(inputData(:,1:d),newMeans);
        [~,labels] = min(dist,[],2);
        oldMeans = newMeans;
        
        mse = 0;
        for j = 1:numberOfClusters
            for k = 1:n
                if labels(k) == j 
                    mse = mse + (pdist2(inputData(k,1:d),oldMeans(j,:)))^2;
                end
            end
        end
        MSE_last(iteration) = mse / n;
        
        for j = 1:numberOfClusters
            newMeans(j,:) = mean(inputData(labels == j,1:d));
        end  
    end
        
    if i == 1 || MSE(size(MSE,1)) > MSE_last(iteration)
        estimatedLabels = labels;
        estimatedMeans = newMeans;
        MSE = MSE_last';        
    end
    MSE_last = [];
end
