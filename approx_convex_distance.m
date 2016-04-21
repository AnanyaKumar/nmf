function [ distance ] = approx_convex_distance( point, T )
  T = T - repmat(point, [1,size(T,2)]);
  a = T(:,1);
  T = T';
  assert(size(T,2) == size(a,1));
  iterations = 400;
  for i = 1:iterations
    % get the point farthest away from point, in the opposite direction
    [~, idx] = min(T * a);
    b = (T(idx,:))';
    ab = dot(a,b);
    aa = dot(a,a);
    bb = dot(b,b);
    c = ((ab-bb)*a + (ab-aa)*b)/(2*ab-aa-bb);
    assert(abs(dot(c,b-a)) < 0.00001);
    a = c;
  end
  distance = norm(a);
end