function [ params ] = parameters(kernel)

    gammas = 2 .^ (1 : 15);
    sigmas = 2 .^ (-5 : 5);

    switch kernel
        case 'linear'
            params.gammas = gammas;
        case 'rbf'
            [x1, x2] = meshgrid(gammas, sigmas);
            params.gammas = x1(:);
            params.sigmas = x2(:);
    end