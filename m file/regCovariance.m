function regCov = regCovariance(alpha,ni,n,covi,totalCov)
a = (1 - alpha) * ni * covi + alpha * n * totalCov;
b = (1 - alpha) * ni + alpha * n;
regCov = a/b;
end