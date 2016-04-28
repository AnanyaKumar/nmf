function [ accuracies ] = evaluate_nmf_pfs( nmf_method, sup_method, approx_method, nmf_sizes )
% The NMF method is first used to project images of digits into a smaller
% dimension (like in PCA). A traditional supervised learning algorithm is used
% on the projected feature space (PFS).
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
    assert(num_labels > 80);
            
    for nmf_size = nmf_sizes
        for cv_trial = 1:num_cv_trials
            perm = randperm(num_labels);
            mid = floor(num_labels/2);
            assert(mid > 20);

            % Generate cross validation samples
            training_images = images(:,perm(1:mid));
            training_labels = labels(perm(1:mid));
            test_images = images(:,perm(mid+1:num_labels));
            test_labels = labels(perm(mid+1:num_labels));

            % Split training set into two
            training_mid = floor(mid/2);
            training_images1 = training_images(:,1:training_mid);
            % training_images2 = training_images(:,training_mid+1:mid);
            % training_labels2 = training_labels(training_mid+1:mid);

            % Get NMF matrix on first half
            disp('training');
            topics = feval(nmf_method, training_images1, nmf_size);

            % Get coefficients for each image on the whole set
            coeffs = cell2mat(cellfun(@(img) feval(approx_method, img, topics),...
                num2cell(training_images,1),'UniformOutput', false));
            coeffs = coeffs';

            % Run supervised training algorithm
            assert(size(coeffs,1) == size(training_labels, 1));
            assert(size(coeffs,2) == size(topics,2));
            trainer = feval(sup_method, coeffs, training_labels);

            % For each testing image, get coefficients
            % Run supervised prediction based on the coefficients
            disp('testing');
            test_coeffs = cell2mat(cellfun(@(img) feval(approx_method, img, topics),...
                num2cell(test_images(:,1:num_tests),1),'UniformOutput', false));
            test_coeffs = test_coeffs';
            pred = predict(trainer, test_coeffs);
            cur_accuracy = sum(pred == test_labels(1:num_tests)) / num_tests;
            disp(cur_accuracy);
            accuracies(acc_idx) = accuracies(acc_idx) + cur_accuracy;
        end
        accuracies(acc_idx) = accuracies(acc_idx) / num_cv_trials;
        acc_idx = acc_idx + 1;
    end
end