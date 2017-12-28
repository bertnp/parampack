clear; clc;
%% generate test output
p_list.p1 = 1:5;
p_list.p2 = 1:3;
n_p = param_linearize(p_list, 0);
outs_cell = cell(n_p, 1);
outs_mat = zeros(n_p, 1);
for p_it = 1:n_p
    p = param_linearize(p_list, p_it);
    outs_cell{p_it}.val1 = p.p1*p.p2;
    outs_cell{p_it}.val2 = p.p1 - p.p2;
    outs_cell{p_it}.it = p_it;
    outs_mat(p_it) = p_it;
end

%% we can extract out the values in a number of ways
% by fulling specifying the fields
val1s = out2array(outs_cell, p_list, 'val1', {'p1', 'p2'});
disp(val1s)

% we can swap the order
val1s = out2array(outs_cell, p_list, 'val1', {'p2', 'p1'});
disp(val1s);

% or just specify one
val1s = out2array(outs_cell, p_list, 'val1', {'p1'});
disp(val1s);

% or the other
val1s = out2array(outs_cell, p_list, 'val1', {'p2'});
disp(val1s);

% if we only have one we don't need the { }
val1s = out2array(outs_cell, p_list, 'val1', 'p1');
disp(val1s);

% if we don't specify a field to retrieve, we can get a reindexed version of the
% original output array
outs_reind = out2array(outs_cell, p_list, [], 'p1');
disp(outs_reind)

% the output can also be just a vector
outs_reind = out2array(outs_mat, p_list, [], {'p2', 'p1'});
disp(outs_reind)