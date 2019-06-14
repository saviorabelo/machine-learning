function [ model ] = train(X_tra, Y_tra, model)
    
    classes = unique(Y_tra, 'rows');
    model.classes = classes;
    k = size(classes, 1);
    covs = cell(k, 1);
    means = cell(k, 1);
    priori = cell(k, 1);
    
    for i = 1:k
        aux = classes(i,:);
        [index, ~] = ismember(Y_tra, aux, 'rows');
        current_tra = X_tra(index,:);
    
        %Add a small value on the main diagonal
        covs{i} = cov(current_tra) + 1e-03*eye(size(current_tra,2));

        means{i} = mean(current_tra);
        priori{i} = size(current_tra,1) / size(X_tra,1);
    end
    
    if isequal(model.discriminant,'linear')
        model.covsLinear = cov(X_tra) + 1e-03*eye(size(current_tra,2));
    end
    model.covs = covs;
    model.means = means;
    model.priori = priori;
end