function [model] = train(X_tra, Y_tra, model)

    y = pinv(model.gamma);
    
    b = [0; ones(size(Y_tra))];
    K = kernel(model, X_tra);
    D = Y_tra * Y_tra';
    A = [0             Y_tra';
        Y_tra   (D .* K) + y * eye(size(D, 1))];

    x = pinv(A) * b;

    model.b = x(1);
    model.alphas = x(2:end);
    model.support_vectors = X_tra;
    model.y = Y_tra;

end