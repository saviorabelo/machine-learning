function output = predict(pattern, model)
    
    answer = zeros(model.k, 1);
    posteriors = zeros(length(model.params), 1);
    n_classes = size(model.classes, 1);

    for i = 1:n_classes
        m = model.params{i};
        for k = 1:model.k
            answer(k,:) = m.pi_k{k} * mvnpdf(pattern, m.mu_k{k}, m.cov_k{k});
        end
        posteriors(i,:) = sum(answer);
    end
    
    [~, index] = max(posteriors);
    output = model.classes(index,:);

end