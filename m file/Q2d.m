%clean all

clear all
close all
imtool close all

set(gcf,'color','w');
set(gca,'color','w');

%(d)
load('dataset3.mat');
inputData = data;
numberOfClusters = 2;
stopTolerance = 0.00001;
numberOfRuns = 10;
[estimatedLabels, estimatedMeans, MSE] = kMeanspp(inputData, numberOfClusters, stopTolerance, numberOfRuns);

subplot(1,3,1);
for i = 1:size(estimatedLabels)
    if inputData(i,3) == 1 
        c1 = plot(inputData(i,1),inputData(i,2), 'r.');
        hold on;
    else c2 = plot(inputData(i,1),inputData(i,2), 'b.');
        hold on;
    end
end
title('True Clustering','FontSize',12);
legend([c1 c2],'Cluster 1','Cluster 2',4)
xlabel('x','FontSize',12);
ylabel('y','FontSize',12);

subplot(1,3,2);
for i = 1:size(estimatedLabels)
    if estimatedLabels(i) == 1 
        c1 = plot(inputData(i,1),inputData(i,2), 'r.');
        hold on;
    else c2 = plot(inputData(i,1),inputData(i,2), 'b.');
        hold on;
    end
end

for i = 1:numberOfClusters
    plot(estimatedMeans(i,1),estimatedMeans(i,2),'k^','MarkerFaceColor','g');
end
title('K-means Clustering','FontSize',12);
legend([c1,c2],'Cluster 1','Cluster 2',4)
xlabel('x','FontSize',12);
ylabel('y','FontSize',12);

subplot(1,3,3);
iteration = 1:size(MSE);
plot(iteration,MSE(iteration),'LineWidth',2);
title('MSE','FontSize',12);
xlabel('iteration','FontSize',12);
ylabel('MSE','FontSize',12);