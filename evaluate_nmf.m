function [ accuracies ] = evaluate_nmf( nmf_method, distance_method, nmf_sizes )
    images = loadMNISTImages('train-images-idx3-ubyte');
    labels = loadMNISTLabels('train-labels-idx1-ubyte');
    accuracies = zeros(size(nmf_sizes));
    acc_idx = 1;
    
    % Normalize the images
    image_norms = cellfun(@norm, num2cell(images, 1));
    images = bsxfun(@rdivide, images, image_norms);
    disp(norm(images(:,1)));
    
    for nmf_size = nmf_sizes
        num_labels = size(labels,1);
        assert(num_labels > 40);
        perm = randperm(num_labels);
        mid = floor(num_labels/2);
        assert(mid > 20);

        % Generate cross validation samples
        training_images = images(:,perm(1:mid));
        training_labels = labels(perm(1:mid));
        test_images = images(:,perm(mid+1:num_labels));
        test_labels = labels(perm(mid+1:num_labels));

        % Perform NMF for images associated with each digit
        separated_images = separate_images(training_images, training_labels);
        nmfs = cell(10,1);
        for j = 1:10
            W = feval(nmf_method, separated_images{j}, nmf_size);
            nmfs{j} = W;
        end

        num_tests = 50;
        accuracies(acc_idx) = reconstruction_accuracy(distance_method, nmfs, test_images(:,1:num_tests), test_labels(1:num_tests));
        acc_idx = acc_idx + 1;
    end
end
