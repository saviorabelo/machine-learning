function [value, output] = predict(pattern, model)
    
    n_classes = size(model.classes, 1);
    likelihood = cell(n_classes, 1);
    posteriors = zeros(n_classes, 1);
    evidence = 0;
    
    for j = 1:n_classes
        likelihood{j} = gaussian_pdf(pattern, model.mean{j}, ...
            model.covs{j}, n_classes);
        %likelihood{j} = mvnpdf(pattern, model.mean{j}, model.covs{j});
        %%MATLAB
    end
    for k = 1:n_classes
        evidence = evidence + likelihood{k} * model.priori{k};
    end
    for i = 1:n_classes
        posteriors(i) = ((likelihood{i} * model.priori{i}) / evidence);
    end
    
    [value, index] = max(posteriors);
    output = model.classes(index,:);

end