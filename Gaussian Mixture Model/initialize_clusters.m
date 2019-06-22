function model = initialize_clusters(X_tra, Y_tra, model)
    
    classes = unique(Y_tra, 'rows');
    model.classes = classes;

    % KMeans centroids to initialise the GMM
    [~, centroids] = kmeans(X_tra, model.k);    
    
    for i = 1:model.k
        model.pi_k{i} = 1/model.k;
        model.mu_k{i} = centroids(i,:);
        model.cov_k{i} = eye(size(X_tra,2));
    end