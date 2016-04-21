function [ intersection ] = line_intersect_positive_circle(base, grad)
  % Returns positive a s.t. base + a * grad intersects the edge of the positive region of the
  % unit circle (origin centered). Assumes that base is inside the unit circle.
  assert(size(base,2) == 1);
  assert(size(grad,2) == 1);
  circle_intersection = line_intersect_circle(base,grad);
  if sum(circle_intersection < 0) == 0
    intersection = circle_intersection;
  else
    intersection = base + grad;
    % quad_intersections = ((-base) ./ grad);
    % for i = 1:size(quad_intersections,1)
    %   if quad_intersections(i) < 0
    %     quad_intersections(i) = inf;
    %   end
    % end
    % coeff = min(quad_intersections);
    % intersection = base + coeff * grad;

    % % Some checks on the intersection
    % num_small = 0;
    % for i = 1:size(intersection,1)
    %   if base(i) <= -0.0001
    %     num_small = num_small + 1;
    %   end
    % end
    % assert(num_small == 0);
    % assert(abs(prod(intersection)) < 0.0001);
  end
end