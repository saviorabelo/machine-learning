function output_classes = predict(centroids, centroid_class, pattern)

k = size(centroids,1);

min_dist = sum((pattern - centroids(1,:)) .^ 2);
output_classes = centroid_class(1,:);
for j=2:k
    dist = sum((pattern - centroids(j,:)) .^ 2);
    if(dist < min_dist)
      min_dist = dist;
      output_classes = centroid_class(j,:);
    end
end