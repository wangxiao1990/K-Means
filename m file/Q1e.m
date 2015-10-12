%clean all

clear all
close all
imtool close all

set(gcf,'color','w');
set(gca,'color','w');

%(e)
fileName = 'datasetP2Train2.mat';
test = 'NO';
[~, ~, ~, data1, data2, ~, data] = getEstimatedParameter(test,fileName);
[alpha, errorRate] = getErrorRateAlpha(test,fileName,data,data1,data2);

[~,lowest] = min(errorRate,[],2);
alpha(lowest)
plot(alpha,errorRate,'LineWidth',2);
title('Training  error  as  a  function  of  alpha  for  datasetP2Train2.mat','FontSize',12);
xlabel('Alpha','FontSize',12);
ylabel('Training error rate','FontSize',12);