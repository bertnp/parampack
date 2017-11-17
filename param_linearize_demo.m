clear; clc;
%%
% if we only have one method (ie. parameter structure), we can just linearize
% the parameters

% parameter lists can be numerical
p_list.p1 = 1:3;

% or cell arrays
p_list.p2 = {'str1', 'str2'};

% we can also specify parameter tuples. Sub-fields in tuples must be of the same
% length, and are treated as a joint parameter, e.g. the combination
% 'hello'/'world' will appear, as will 'foo'/'bar', but NOT 'hello'/'bar' or
% 'foo'/'world'
p_list.ptuple0.joint1 = {'hello', 'foo'};
p_list.ptuple0.joint2 = {'world', 'bar'};

% get the total number of parameter combinations by specifying index 0
n_total = param_linearize(p_list, 0);

% and loop through them
for ii = 1:n_total
    clc;
    p = param_linearize(p_list, ii)
    pause();
end

%%
% we can use param_slice to get the linear index for a certain parameter
% configuration
clc;
p_it = param_slice(p_list, {'p2', 'p1', 'joint1'}, [2 3 1]);
p = param_linearize(p_list, p_it)

%%
% if we omit any parameters, the first one is returned
clc;
p_it = param_slice(p_list, {'p2', 'joint2'}, [2 2]);
p = param_linearize(p_list, p_it)

%%
% if we have another parameter list, g_list, which has a subset of fields, f,
% which are also in p_list, then given a linear index for p_list, p_it, we can
% get the linear index for g_list, g_it, so that
% param_linearize(p_list, p_it) and param_linearize(g_list, g_it) match on f
g_list = [];
g_list.p2 = p_list.p2;
g_list.p1 = p_list.p1;
g_list.p3 = {'one', 'two', 'three'};

for p_it = 1:n_total
    clc;
    p = param_linearize(p_list, p_it);
    disp(p_it); disp(p);

    g_it = param_translate(p_list, p_it, g_list);
    g = param_linearize(g_list, g_it);
    disp(g_it); disp(g);
    pause();
end

%%
% we can also translate indices if g_list or p_list contains fields which are
% sub-fields in tuples in the other
g_list = [];
g_list.p2 = p_list.p2;
g_list.joint1 = p_list.ptuple0.joint1;
g_list.p3 = {'one', 'two', 'three'};

for p_it = 1:n_total
    clc;
    p = param_linearize(p_list, p_it);
    disp(p_it); disp(p);

    g_it = param_translate(p_list, p_it, g_list);
    g = param_linearize(g_list, g_it);
    disp(g_it); disp(g);
    pause();
end


%%
% if we have multiple methods with different parameter structures, we can
% combine them into a single param pack struct where p.(method) contains the
%lineareized parameter set
clc;
big_list = [];
big_list.method_p = p_list;
big_list.method_g = g_list;

% now suppose we have some global parameters, global_opts, that all methods
% should inherit. we can define them once, then pack them into all of the method
% sub-structs

p_global.global_param = 0.1:0.1:0.4;
big_list = param_method_pack(big_list, p_global);
disp('method p:'); disp(big_list.method_p);
disp('method g:'); disp(big_list.method_g);

%%
% your global options can be tuples, and if the param pack already has them,
% param_method_pack will combine them, not overwrite them:
clc;
big_list = [];
big_list.method_p.p1 = 1:3;
big_list.method_p.ptuple.x = 1:5;
big_list.method_g.g1 = {'g1', 'g2'};
big_list.method_g.ptuple.y = linspace(0, 1, 5);

global_opts = [];
global_opts.global = 2:2:6;
global_opts.ptuple.z = 1:2:10;
big_list = param_method_pack(big_list, global_opts);

disp('method p:'); disp(big_list.method_p);
disp('method p.ptuple:'); disp(big_list.method_p.ptuple);
disp('');
disp('method g:'); disp(big_list.method_g);
disp('method g.ptuple:'); disp(big_list.method_g.ptuple);

return;
%%
% things you shouldn't do

% have a field with the same name as a tuple sub-field:
p_list.subfield = 1:10;
p_list.ptuple.subfield = 2:5;