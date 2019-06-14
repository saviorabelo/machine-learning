function [data_new] = normalize(data, n_attri)
% NORMALIZE Summary of this function goes here
% Detailed explanation goes here

    data_new = data;
    [~,n] = size(data);
    
    if nargin==1
        n_attri = n;
    end
    
    %minimum = repmat(min(data(:,1:n_attri)), m, 1);
    %maximum = repmat(max(data(:,1:n_attri)), m, 1);
    %data_new(:,1:n_attri)  = (data(:,1:n_attri) - minimum) ./ (maximum - minimum);
    
 	minimum = min(data(:,1:n_attri));
    maximum = max(data(:,1:n_attri));
    data_new(:,1:n_attri)  = (data(:,1:n_attri) - minimum) ./ (maximum - minimum);
    
    %means = mean(data(:,1:n_attri));
    %standard_d = std(data(:,1:n_attri));
    %data_new(:,1:n_attri)  = (data(:,1:n_attri) - means) ./ standard_d;

end

