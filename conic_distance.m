function [ distance ] = conic_distance( point, T )
  approx = conic_approx(point, T);
  distance = norm(T * approx - point);
end