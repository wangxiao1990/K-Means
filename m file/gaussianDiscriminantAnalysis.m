function [score] = gaussianDiscriminantAnalysis(inputData, mu, sigma, prior)
%
% Function to simulate data from k Gaussian densities (1 for each class) in d dimensions.
%
% INPUTS:
%   inputData   - nSamples-by-d array with samples to be scored
%   mu          - cell with the class dependent d-dimensional mean vector
%   sigma       - k-by-1 cell with the class dependent d-by-d covariance matrix
%   prior       - k-by-1 vector with class dependent mean
%
% OUTPUTS:
%   score        - nSamples-by-nClass array with the simulated data distributed along the rows

% Check inputs
nClass = numel(mu);
nDimensions = size(inputData,2);
nSamples = size(inputData, 1);

if nargin == 2
    sigma = [];
    prior = ones(nClass,1)/nClass;
elseif nargin == 3    
    prior = ones(nClass,1)/nClass;
end

if isempty(sigma)
	sigma = eye(nDimensions);
end

if ~iscell(sigma)
    if isscalar(sigma)
        sharedSigma = (sigma^2)*eye(nDimensions);
    else
        sharedSigma = sigma;
    end
    sigma = cell(nClass, 1);
    sigma(:) = {sharedSigma};
end

% Transpose data array to perform vectorized operations when computing the
% discriminant
inputData = inputData.'; 

score = zeros(nSamples, nClass);

for idxClass = 1:nClass;
    % Correct shape of mu vector
    mu{idxClass} = reshape(mu{idxClass}, [], 1);        
    
    % Center data 
    zeroMeanData = bsxfun(@minus, inputData, mu{idxClass});
    
    % Compute the scores
    score(:, idxClass) = -0.5*sum(zeroMeanData.*(sigma{idxClass}\zeroMeanData)) - ...
                         0.5*log(det(sigma{idxClass})) + ...
                         log(prior(idxClass));
                     
    % Alternative form:
    % invSigma = inv(sigma{idxClass});
    % Wi = -0.5*invSigma;
    % wi = sigma{idxClass}\mu{idxClass};
    % wi0 = -0.5*mu{idxClass}.'*wi - 0.5*log(det(sigma{idxClass})) + log(prior(idxClass));
    % score(:, idxClass) = sum(inputData.*(Wi*inputData)) + wi.' * inputData + wi0;
end

end