function [ topics ] = trivial_convex_nmf( matrix, nmf_size )
    topics = matrix(:,1:nmf_size);
end
