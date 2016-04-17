eps = 0.001;

assert(conic_distance([0;1],[[0;1]]) < eps);
assert(conic_distance([0;2],[[0;1]]) < eps);
assert(conic_distance([0;0],[[0;1]]) < eps);
assert(conic_distance([0.2;0.2],[[0;1],[1;0]]) < eps);
assert(conic_distance([5;4],[[0;1],[1;0]]) < eps);
assert(conic_distance([5;0],[[0;1],[1;0]]) < eps);
assert(conic_distance([0;5],[[0;1],[1;0]]) < eps);
assert(conic_distance([5;4],[[0;1],[1;0],[1;1]]) < eps);

assert(conic_distance([1;2],[[0;1]]) > eps);
assert(conic_distance([-1;0.2],[[0;1],[1;0]]) > eps);
assert(conic_distance([3;-1],[[0;1],[1;0]]) > eps);

assert(convex_distance([0;1],[[0;1]]) < eps);
assert(convex_distance([0;1],[[0;1],[1;0]]) < eps);
assert(convex_distance([1;0],[[0;1],[1;0]]) < eps);
assert(convex_distance([0.5;0.5],[[0;1],[1;0]]) < eps);
assert(convex_distance([0.2;0.2],[[0;1],[1;0],[0;0]]) < eps);
assert(convex_distance([0;0],[[0;1],[1;0],[0;0]]) < eps);
assert(convex_distance([1;0],[[0;1],[1;0],[0;0]]) < eps);
assert(convex_distance([0;1],[[0;1],[1;0],[0;0]]) < eps);
assert(convex_distance([0.2;0.6],[[0;1],[1;0],[0;0]]) < eps);

assert(convex_distance([0;2],[[0;1]]) > eps);
assert(convex_distance([0;0.2],[[0;1]]) > eps);
assert(convex_distance([0;0],[[0;1]]) > eps);
assert(convex_distance([1;1],[[0;1],[1;0]]) > eps);
assert(convex_distance([0;0],[[0;1],[1;0]]) > eps);
assert(convex_distance([0.7;0.7],[[0;1],[1;0],[0;0]]) > eps);
