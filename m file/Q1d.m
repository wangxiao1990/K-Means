%clean all

clear all
close all
imtool close all

%(d)
fileName = 'datasetP2Train2.mat';
test =  'NO';
[classMean, classCov, totalCov] = getEstimatedParameter(test,fileName);

class1Mean = classMean(1,:)
class2Mean = classMean(2,:)
class3Mean = classMean(3,:)

class1Cov = classCov(1:3,:)
class2Cov = classCov(4:6,:)
class3Cov = classCov(7:9,:)