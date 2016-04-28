function [ accuracies ] = evaluate_knn(num_neighbors)
% Evaluates the accuracy of an NMF method used to classify digits based on
% reconstruction error (RCE).
    images = loadMNISTImages('train-images-idx3-ubyte');
    labels = loadMNISTLabels('train-labels-idx1-ubyte');
    accuracies = zeros(1);
    acc_idx = 1;
    
    num_cv_trials = 5;
    num_tests = 300;
    num_labels = 4000;
    assert(num_labels > 40);
            
    for cv_trial = 1:num_cv_trials
        perm = randperm(num_labels);
        mid = floor(num_labels/2);
        assert(mid > 20);

        % Generate cross validation samples
        training_images = images(:,perm(1:mid));
        training_labels = labels(perm(1:mid));
        test_images = images(:,perm(mid+1:num_labels));
        test_labels = labels(perm(mid+1:num_labels));

        disp('training');
        mdl = fitcknn(training_images',training_labels,'NumNeighbors',num_neighbors);

        disp('testing');
        predictions = predict(mdl, test_images');
        cur_accuracy = sum(predictions == test_labels) / size(test_labels,1);
        accuracies(acc_idx) = accuracies(acc_idx) + cur_accuracy;
        disp(cur_accuracy);
    end
    accuracies(acc_idx) = accuracies(acc_idx) / num_cv_trials;
    acc_idx = acc_idx + 1;
end
