function [Alpha, errorRate] = getErrorRateAlpha(test,fileName,data,data1,data2)

[classMean, classCov, totalCov, data1Train, data2Train, data3Train, dataTrain] = getEstimatedParameter(test, fileName);

mean_cell = cell(3,1);
cov_cell = cell(3,1);

mean_cell(1,1) = {classMean(1,:)};
mean_cell(2,1) = {classMean(2,:)};
mean_cell(3,1) = {classMean(3,:)};

error = 0;
counter = 1;

for alpha = 0:0.001:1
    cov1 = regCovariance(alpha,size(data1Train,1),size(dataTrain,1),classCov(1:3,:),totalCov);
    cov2 = regCovariance(alpha,size(data2Train,1),size(dataTrain,1),classCov(4:6,:),totalCov);
    cov3 = regCovariance(alpha,size(data3Train,1),size(dataTrain,1),classCov(7:9,:),totalCov);
     
    cov_cell(1,1) = {cov1};
    cov_cell(2,1) = {cov2};
    cov_cell(3,1) = {cov3};
             
    score = gaussianDiscriminantAnalysis(data,mean_cell,cov_cell);
     
    for i = 1:size(data,1)
        if i <= size(data1,1)
            if score(i,1) < score(i,2)
                error = error + 1;
            elseif score(i,1) < score(i,3)
                error = error + 1;
            end
        end
            
        if i > size(data1,1) && i <= size(data1,1) + size(data2,1)
            if score(i,2) < score(i,1)
                error = error + 1;
            elseif score(i,2) < score(i,3)
                error = error + 1;
            end
        end
             
        if i > size(data1,1) + size(data2,1)
            if score(i,3) < score(i,1)
                error = error+1;
            elseif score(i,3) < score(i,2)
                error = error + 1;
            end
        end
    end
    
    Alpha(counter) = alpha;
    errorRate(counter) = error/size(data,1);
    error = 0;
    counter = counter + 1;
end
end