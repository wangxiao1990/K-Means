function mlcov = mlCovariance(data)
total = zeros(size(data,2));
N = size(data,1);
for k = 1:N
   total = total + (data(k,:) - mean(data))'*(data(k,:) - mean(data));
end
mlcov = total/N;