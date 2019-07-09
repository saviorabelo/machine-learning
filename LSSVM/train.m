function [model] = train(X_tra, Y_tra, model)

    C = pinv(model.gamma);
    K = kernel(model, X_tra);
    D = Y_tra * Y_tra';
    I = eye(size(D, 1));
    omega = (D .* K) + C * I;
    M = [  0  Y_tra';
        Y_tra omega];
    
    b = [0; ones(size(Y_tra))];
    x = pinv(M) * b;

    model.b = x(1);
    model.alphas = x(2:end);
    model.support_vectors = X_tra;
    model.y = Y_tra;

end