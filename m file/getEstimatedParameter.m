function [classMean, classCov, totalCov, data1, data2, data3, data] = getEstimatedParameter(test, fileName)
if strcmp(test,'YES')
    A = load(fileName);
    data = A.dataTest;
    classIndex = A.classIndexTest;

else
    A = load(fileName);
    data = A.data;
    classIndex = A.classIndex;
end

a = 1;
b = 1;
c = 1;

for i = 1:size(classIndex,1)
    if classIndex(i) == 1
        data1(a,:) = data(i,:);
        a = a + 1;
    end
    
    if classIndex(i) == 2
        data2(b,:) = data(i,:);
        b = b + 1;
    end
    
    if classIndex(i) == 3
        data3(c,:) = data(i,:);
        c = c + 1;
    end
end
    
    classMean = [mean(data1);mean(data2);mean(data3)];
    classCov = [mlCovariance(data1);mlCovariance(data2);mlCovariance(data3)];
    totalCov = mlCovariance(data);
end