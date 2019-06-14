function [accu, sens, spec, prec] = train(X_test, Y_test, centroids, centroid_class)
    
m_output = zeros(size(Y_test));

%Calculates the distance of the classes to the centroid
for i=1:size(X_test,1)
    m_output(i,:) = predict(centroids, centroid_class, X_test(i,:));
end

%% Confusion matrix
%figure(1)
%plotconfusion(m_target',m_output','MDC');
[~,r]= confusion_aux.getMatrix(l_convert(Y_test),l_convert(m_output));
%C = confusion(l_convert(m_target),l_convert(m_output));
 accu = r.Accuracy;
 sens = r.Sensitivity;
 spec = r.Specificity;
 prec = r.Precision;
