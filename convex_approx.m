function [ approx ] = convex_approx( point, T )
% Returns a convex linear combination of the columns in T that best
% approximates point

    % set up quadratic programming
    assert(size(point,1) == size(T,1));
    d = size(point, 1); % number of pixels in each image
    k = size(T, 2);

    % The quadratic terms
    H = zeros(k,k);
    for i = 1:k
        for l = 1:k
            if i == l
                for j = 1:d
                    H(i,i) = H(i,i) + 2 * T(j,i) * T(j,i);
                end
            else
                for j = 1:d
                    H(i,l) = H(i,l) + 2 * T(j,i) * T(j,l);
                end
            end
        end
    end

    % The linear terms
    f = zeros(k,1);
    for i = 1:k
        for j = 1:d
           f(i) =  f(i) - 2 * T(j,i) * point(j);
        end
    end
    
    % The combinations should be convex
    A = [ones(1,k); -ones(1,k)];
    b = [1, -1];
    lb = zeros(k,1);

    % Optimize!
    options = optimoptions('quadprog','Algorithm','interior-point-convex','Display','off');
    [approx] = quadprog(H,f,A,b,[],[],lb,[],[],options);
end
