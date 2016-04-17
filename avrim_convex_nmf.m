function [ topics ] = avrim_convex_nmf( matrix, nmf_size )
    topics = matrix(:,1);
    sample_size = 15;
    for i = 1:nmf_size
        perm = randperm(size(matrix, 2));
        perm = perm(1:sample_size);
        sample = matrix(:,perm);
        dists = cellfun(@(x) convex_distance(x, topics), num2cell(sample,1));
        [~, idx] = max(dists);
        topics = [topics, matrix(:,perm(idx))];
    end
end
