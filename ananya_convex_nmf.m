function [ topics ] = ananya_convex_nmf(matrix, nmf_size)
    topics = matrix(:,1);
    sample_size = 15;
    for i = 1:nmf_size
        perm = randperm(size(matrix,2));
        perm = perm(1:sample_size);
        sample = matrix(:,perm);
        approx = cell2mat(cellfun(@(x) convex_approx(x, topics),num2cell(sample,1), 'UniformOutput', false));
        closest = topics * approx;
        dists = cellfun(@norm, num2cell(sample-closest,1));
        [~, idx] = max(dists);
        intersection = line_intersect_positive_circle(closest(:,idx),sample(:,idx)-closest(:,idx));
        assert(size(intersection,1) == size(topics,1))
        topics = [topics, intersection];
    end
end
