function [ accuracy ] = reconstruction_accuracy( distance_method, nmfs, test_images, test_labels )
% Test how "good" the NMF was based on reconstruction error

    accuracy = 0;
    disp(['size: ', num2str(size(nmfs{1}, 2))]);
    num_tests = size(test_labels, 1);
    for test_num = 1:num_tests
        image = test_images(:,test_num);
        label = test_labels(test_num);
        best_proximity = -1;
        best_guess = -1;
        
        for guess_digit = 1:10
            T = nmfs{guess_digit};
            proximity = 1.0/feval(distance_method, image, T);
            assert(proximity > 0);
            if proximity > best_proximity
                best_guess = guess_digit - 1;
                best_proximity = proximity;
            end
        end
        assert(best_proximity > 0);
        assert(0 <= best_guess && best_guess <= 9);
        % disp(['guess: ', num2str(best_guess), ', actual: ', num2str(label)]);
        if best_guess == label
            accuracy = accuracy + 1;
        end
    end
    accuracy = accuracy / num_tests;
end
