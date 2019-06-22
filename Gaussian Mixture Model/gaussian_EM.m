function [params] = gaussian_EM(X, model)
    
    % cov_k -> covariance
    % pi_k -> mixing coefficient
    % gamma_nk -> responsability

    K = model.k;
    [N, d] = size(X);
    
    % KMeans centroids to initialise the GMM
    [~, centroids] = kmeans(X, K);    
    for i = 1:K
        params.pi_k{i} = 1/K;
        params.mu_k{i} = centroids(i,:);
        params.cov_k{i} = cov(X) + 0.001*eye(d);
    end
    
    like_vector = zeros(model.maxiters, 1);
    n_epochs = 0;
    like_old = 0;
    while(true)
        
        % Expectation step
        totals = zeros(N, 1);
        gamma_nk = zeros(N, 1);
        for j = 1:K
            for i = 1:N
                gamma_nk(i) = params.pi_k{j} * mvnpdf(X(i,:), params.mu_k{j}, params.cov_k{j});
                totals(i) = totals(i) + gamma_nk(i);
            end
            params.gamma_nk{j} = gamma_nk ./ totals;
            params.totals{j} = totals;
        end

        % Maximization Step
        for j = 1:K
            gamma_nk  = params.gamma_nk{j};
            cov_k = zeros(d,d);
            N_k = sum(gamma_nk);
            pi_k = N_k / N;
            mu_k = sum(X .* gamma_nk) / N_k;

            for i = 1:N
                diff = X(i,:) - mu_k;
                cov_k = cov_k + gamma_nk(j,:) * (diff' * diff);
            end
            cov_k = cov_k / N_k;

            params.pi_k{j} = pi_k;
            params.mu_k{j} = mu_k;
            params.cov_k{j} = cov_k + 0.001*eye(d);
        end

        % Get likelihood
        like = 0;
        for j = 1:K
            like = like + sum(log(params.totals{j}));
        end
        
        n_epochs = n_epochs + 1;
        like_vector(n_epochs) = like;
        
        % Stoping Condition
        if ((abs(like_old - like) <= model.threshold) || ...
                (n_epochs >= model.maxiters))
            break;
        end
        like_old = like;
        
    end
    %plot((1:length(like_vector)),like_vector)
    
end
    