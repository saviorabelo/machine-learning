function [ model ] = train(X_tra, Y_tra, model)
    
    classes = unique(Y_tra, 'rows');
    model.classes = classes;
    k = length(classes);
    covs = cell(k, 1);
    means = cell(k, 1);
    priori = cell(k, 1);
    
    for i = 1:k
        aux = classes(i,:);
        [index, ~] = ismember(Y_tra, aux, 'rows');
        current_tra = X_tra(index,:);
    
        %Adiciona um pequeno valor na diagonal principal
        covs{i} = cov(current_tra) + .0001 * eye(size(current_tra,2));
        %variance{i} = std(current_tra) .^ 2;

        means{i} = mean(current_tra);
        priori{i} = size(current_tra,1) / size(X_tra,1);
    end

    model.covs = covs;
    model.mean = means;
    model.priori = priori;
end