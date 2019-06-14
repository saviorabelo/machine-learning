function output = predict(pattern, model)
    
    n_classes = size(model.classes, 1);
    answer = zeros(n_classes, 1);
    if isempty(model.discriminant)
        model.discriminant = 'quadratico';
    end
    
    switch model.discriminant
        case 'linear'
            %Matriz de covariâncias é igual para todas as classes
            for i=1:n_classes
                mi = pattern - model.means{i};
                answer(i) = (-1/2) * (mi * pinv(model.covsLinear) * mi') ...
                    + log(model.priori{i});
            end
        case 'quadratico'
            %Leva em consideração que as matrizes de covariância são
            %diferentes e que as classes não são equiprováveis.
            for i=1:n_classes
                ci = log(det(model.covs{i}));
                mi = pattern - model.means{i};
                answer(i) = (-1/2) * (mi * pinv(model.covs{i}) * mi' + ci) ...
                    + log(model.priori{i});
            end
        otherwise
        	error('Erro!\n');
    end
    
    [~, index] = max(answer);
    output = model.classes(index,:);

end