function [K] = kernel(model, x, x2)

    if nargin < 3, x2 = x; end

    switch model.kernel
        case 'linear'
            K = x * x2';
        case 'rbf'
            K = exp(-(pdist2(x, x2).^2) / (2 * model.sigma^2));
        case 'polynomial'
            d = 2;
            K = (x * x2' + 1).^d;
        otherwise
                error([type ' is not a valid kernel!'])
    end
    