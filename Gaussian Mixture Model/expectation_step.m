function model = expectation_step(X_tra, model)

    n_classes = size(model.classes, 1);
    
    totals = zeros(size(X_tra,1), 1);
    gamma_nk = zeros(size(X_tra,1), 1);
    for j = 1:model.k
        for i = 1:size(X_tra,1)
            gamma_nk(i) = model.pi_k{j} * ...
                gaussian_pdf(X_tra(i,:), model.mu_k{j}, ...
                model.cov_k{j}, n_classes);
            totals(i) = totals(i) + gamma_nk(i);
        end
        model.gamma_nk{j} = gamma_nk;
        model.totals{j} = totals;
    end
    for j = 1:model.k
        model.gamma_nk{j} = model.gamma_nk{j} ./ model.totals{model.k};
    end