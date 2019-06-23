function [m_output] = test_segmentation(X, model)

model.classes = [0;1];

for i=1:size(X,1)
    m_output(i,:) = predict(X(i,:), model);
end
    