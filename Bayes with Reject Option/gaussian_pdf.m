function [g] = gaussian_pdf(pattern, mi, covari, k)
    
    %univariate Gaussian
    %g = (1./(sqrt(2*pi)*theta)) .* exp(-1/2 .* (((pattern - mi) .^ 2) ./ theta.^2));
    
    %multivariate generalization of a Gaussian pdf in the k-dimensional space
    g = (1/(sqrt((2*pi)^k * det(covari)))) * ...
        exp(-1/2 .* (((pattern - mi) * inv(covari)) * (pattern - mi)'));
    
end