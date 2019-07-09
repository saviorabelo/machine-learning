function [model] = train(X_tra, Y_tra, params)

    switch params.kernel
        case 'linear'
            model = fitcsvm(X_tra, Y_tra, ...
                            'Solver', 'SMO', ...
                            'BoxConstraint', params.constraint, ...
                            'KernelFunction', params.kernel);
        case 'rbf'
            model = fitcsvm(X_tra, Y_tra, ...
                            'Solver', 'SMO', ...
                            'BoxConstraint', params.constraint, ...
                            'KernelFunction', params.kernel, ...
                            'KernelScale', params.sigma);
        case 'polynomial'
            model = fitcsvm(X_tra, Y_tra, ...
                            'Solver', 'SMO', ...
                            'BoxConstraint', params.constraint, ...
                            'KernelFunction', params.kernel, ...
                            'PolynomialOrder', 2);
    end

end