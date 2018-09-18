clc; clear;

p_list.a = 1:3;
p_list.b = {'a', 'b', 'c'};
p_list.c = 1:10;

%% We can specify each field

param_slice(p_list, {'a', 'b', 'c'}, [2 1 2])
param_linearize(p_list, 11)

%% If we lave a field out, all compatible indices are returned
clc;
param_slice(p_list, {'a', 'b'}, [2 1])
param_linearize(p_list, 2)
param_linearize(p_list, 83)

%% We can specify arbitrary slices
clc;
param_slice(p_list, {'a', 'b', 'c'}, {2, 1, [5, 10]})
param_linearize(p_list, 38)
param_linearize(p_list, 83)