%clean all

clear all
close all
imtool close all

set(gcf,'color','w');
set(gca,'color','w');

%(f)
fileName = 'datasetP2Test.mat';
test = 'YES';
[~, ~, ~, data1, data2, ~, data] = getEstimatedParameter(test,fileName);

fileName = 'datasetP2Train2.mat';
test = 'NO';
[alpha, errorRate] = getErrorRateAlpha(test,fileName,data,data1,data2);

[~,lowest] = min(errorRate,[],2);
alpha(lowest)
plot(alpha,errorRate,'LineWidth',2);
title('Training  error  as  a  function  of  alpha  for  datasetP2Test2.mat','FontSize',12);
xlabel('Alpha','FontSize',12);
ylabel('Training error rate','FontSize',12);