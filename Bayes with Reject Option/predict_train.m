function [predictions] = predict_train(X_test, Y_test, model)

prob = zeros(1,size(Y_test,1));
classes = zeros(size(Y_test));
for i=1:size(X_test,1)
    [prob(i), classes(i,:)] = predict(X_test(i,:), model);
end

predictions.prob = prob;
predictions.classes = classes';