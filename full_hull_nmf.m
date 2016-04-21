function [ topics ] = full_hull_nmf( matrix, nmf_size )
    if nmf_size < size(matrix,2)
        topics = matrix(:,1:nmf_size);
    else
        topics = matrix;
    end
end
