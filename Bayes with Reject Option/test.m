function [valores, accu, sens, spec, prec] = test(X_test, Y_test, model)
valores = [];
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
    valores = [valores; wr t (1-error) rejection (error + wr*rejection)];
    aux_t = aux_t + 1;
end


%% Confusion matrix

%figure(1)
%plotconfusion(Y_test',m_output','Bayesian');
[~,r]= confusion_aux.getMatrix(l_convert(Y_test)', predictions.classes);
accu = r.Accuracy;
sens = r.Sensitivity;
spec = r.Specificity;
prec = r.Precision;