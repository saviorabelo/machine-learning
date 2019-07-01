function output = predict(pattern, model)
    
    K = kernel(model, model.support_vectors, pattern);
    output = sign(sum(model.alphas .* model.y .* K) + model.b);

end