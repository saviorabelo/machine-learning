function [answer] = test(X_test, Y_test, model)

answer = [];
aux_t = 1;
for t = model.optimumParamsT
    predictions = predict_train(X_test, Y_test, model);
    predict = predictions.classes;
    predict(predictions.prob < 0.5 + t) = 0;
    
    if any(predict == 0)
        idx = (predict == 0);
        rejection = sum(idx) / size(X_test,1);
        aux = l_convert(Y_test)';
        error = sum(aux(~idx) ~= predict(~idx)) / ...
            (size(Y_test,1) - sum(idx));
    else
        rejection = 0;
        error = sum(l_convert(Y_test)' ~= predict) / size(Y_test,1);
    end
    wr = model.rej_ratio(aux_t);
    answer = [answer; wr t (1-error) rejection (error + wr*rejection)];
    aux_t = aux_t + 1;
end

