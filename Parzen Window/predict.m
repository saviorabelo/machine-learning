function output = predict(pattern, model)
    
    n_classes = size(model.classes, 1);
    likelihood = cell(n_classes, 1);
    posteriors = zeros(n_classes, 1);
    evidence = 0;
    
    for j = 1:n_classes
        likelihood{j} = parzen_window(pattern, model.train{j}, model.optimum_width);
    end
    for k = 1:n_classes
        evidence = evidence + likelihood{k} * model.priori{k};
    end
    for i = 1:n_classes
        posteriors(i) = ((likelihood{i} * model.priori{i}) / evidence);
    end
    
    [~, index] = max(posteriors);
    output = model.classes(index,:);

end