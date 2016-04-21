
adaboost_tree = @(X,Y) fitensemble(X,Y,'TotalBoost',500,'Tree');
disp(evaluate_nmf_pfs('nnmf',adaboost_tree,'conic_distance',50:25:200));

disp(evaluate_nmf_rce('full_hull_nmf', 'approx_convex_distance', 1000));
disp(evaluate_nmf_rce('ananya_convex_nmf', 'convex_distance', 10:10:80));
disp(evaluate_nmf_rce('trivial_convex_nmf', 'convex_distance', 10:10:80));
disp(evaluate_nmf_rce('nnmf', 'conic_distance', 80:10:80));
