clear; clc;
% p_list: {p1, p2, ptuple3.{a, b}, p4}
p_list.p1 = [];
p_list.p2 = [];
p_list.ptuple0.a = [];
p_list.ptuple0.b = [];
p_list.p4 = [];

% s_list: {x, y, a, ptuple.{p1, s}, z}
s_list.x = [];
s_list.y = [];
s_list.a = [];
s_list.ptuple.p1 = [];
s_list.ptuple.s = [];
s_list.z = [];

% disp('p_list'); disp(p_list);
% disp('s_list'); disp(s_list);
%% By default, fields = fieldnames(p_list), so,
% get_field_ind(p_list, 'p2') = 2
fprintf('get_field_ind(p_list, "p2\"): %u\n', get_field_ind(p_list, 'p2'));

%% But we may define a subset (and reordering) by specifying fields:
% get_field_ind(p_list, 'p2', {'p2', 'p4'}) = 1
fprintf('get_field_ind(p_list, "p2", {"p2", "p4"}): %u\n', ...
    get_field_ind(p_list, 'p2', {'p2', 'p4'}));


%%
% We may have gotten field from s_list, but wish to find the corresponding index
% in p_list. For example, ptuple comes from s_list, and contains sub-field p1,
% so it should match the first field in p_list. The following doesn't work
% because p_list doesn't know the subfields of ptuple:
% get_field_ind(p_list, 'ptuple') = []
fprintf('get_field_ind(p_list, "ptuple"): %u\n', ...
    get_field_ind(p_list, 'ptuple'));

% But if we specify the s_list, we get a match
% get_field_ind(p_list, 'ptuple', [], s_list) = 1
fprintf('get_field_ind(p_list, "ptuple", [], s_list): %u\n', ...
    get_field_ind(p_list, 'ptuple', [], s_list) );