function [centroids, centroid_class] = computeCentroids(X_tra, Y_tra)

    centroid_class=unique(Y_tra, 'rows');
    k=length(centroid_class);

    for i=1:k
        aux = centroid_class(i,:);
        [index, ~] = ismember(Y_tra, aux, 'rows');
        centroids(i,:)=mean(X_tra(index,:));
    end
end