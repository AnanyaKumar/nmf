function [ distance ] = convex_distance( point, T )
  approx = convex_approx(point, T);
  distance = norm(T * approx - point);
end