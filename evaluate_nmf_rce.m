function [ accuracies ] = evaluate_nmf_rce( nmf_method, distance_method, nmf_sizes )
% Evaluates the accuracy of an NMF method used to classify digits based on
% reconstruction error (RCE).
    images = loadMNISTImages('train-images-idx3-ubyte');
    labels = loadMNISTLabels('train-labels-idx1-ubyte');
    accuracies = zeros(size(nmf_sizes));
    acc_idx = 1;
    
    % Normalize the images
    image_norms = cellfun(@norm, num2cell(images, 1));
    images = bsxfun(@rdivide, images, image_norms);
    
    num_cv_trials = 5;
    num_tests = 300;
    num_labels = 5000;
    assert(num_labels > 40);
            
    for nmf_size = nmf_sizes
        for cv_trial = 1:num_cv_trials
            disp('training');
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
                nmfs{j} = feval(nmf_method, separated_images{j}, nmf_size);
            end
            
            disp('reconstructing');
            accuracies(acc_idx) = accuracies(acc_idx) + reconstruction_accuracy(distance_method, nmfs, test_images(:,1:num_tests), test_labels(1:num_tests));
            disp(accuracies(acc_idx));
        end
        accuracies(acc_idx) = accuracies(acc_idx) / num_cv_trials;
        acc_idx = acc_idx + 1;
    end
end
