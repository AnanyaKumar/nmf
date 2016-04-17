function [ intersection ] = line_intersect_circle(base, grad)
  % Returns intersection of the line base + x * grad with the unit circle.
  % Assumes that base is inside the unit circle.
  assert(size(base,2) == 1);
  assert(size(grad,2) == 1);
  a = sum(grad.^2);
  b = 2 * dot(base, grad);
  c = sum(base.^2)-1;
  sol = (-b+sqrt(b^2-4*a*c))/(2*a);
  intersection = base+sol*grad;
  assert(abs(norm(intersection)-1) < 0.0001);
end