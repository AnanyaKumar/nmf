
images = loadMNISTImages('train-images-idx3-ubyte');
labels = loadMNISTLabels('train-labels-idx1-ubyte');

% Normalize the images
image_norms = cellfun(@norm, num2cell(images, 1));
images = bsxfun(@rdivide, images, image_norms);

separated_images = separate_images(images, labels);
images_1 = separated_images{1};
centroid = mean(images_1, 2);
dists = cellfun(@(x)(norm(x-centroid)), num2cell(images_1,1));
hist(dists);
