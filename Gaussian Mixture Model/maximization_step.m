function model = maximization_step(X_tra, model)
    
    % Maximization Step
    [m,n] = size(X_tra);
    for j = 1:model.k
        gamma_nk  = model.gamma_nk{j};
        cov_k = zeros(n,n);
        N_k = sum(gamma_nk);
        pi_k = N_k / m;
        mu_k = sum(X_tra .* gamma_nk) / N_k;
        
        for i = 1:size(X_tra,1)
            diff = X_tra(i,:) - mu_k;
            cov_k = cov_k + gamma_nk(j,:) * (diff' * diff);
        end
        cov_k = cov_k / N_k;
        
        model.pi_k{j} = pi_k;
        model.mu_k{j} = mu_k;
        model.cov_k{j} = cov_k;
    end