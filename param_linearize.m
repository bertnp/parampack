function [p_out, p_ind] = param_linearize(p_list, p_it)
%PARAM_LINEARIZE Linearize multiple parameter vectors
%
% Inputs
%   p_list : struct where p_list.param_j is an array of values for param j
%   p_it   : linear index
%
% Outputs
%   p : struct containing the p_it configuration. returns total number of
%   configurations if p_it == 0.

fields = fieldnames(p_list);
n_fields = numel(fields);
n_per_field = struct_numel(p_list);
n_total_params = prod(n_per_field);

if p_it == 0
    p_out = n_total_params;
    return;
elseif sum(p_it > n_total_params) > 0
    error('Index exceeds number of configurations in p_list.');
end

p_out = cell(numel(p_it),1);
for p_indx = 1:numel(p_it)
    p_t = p_it(p_indx);
    % get indices for parameter configuration
    p_ind = cell(1,n_fields);
    [p_ind{1:n_fields}] = ind2sub(n_per_field, p_t);
    p = [];
    for f_it = 1:n_fields
        field = fields{f_it};
        if isptuple(p_list, field) % if this is a tuple, add all of the tuple fields
            tuple_fields = fieldnames(p_list.(field));
            for tf_it = 1:numel(tuple_fields)
                list = p_list.(field).(tuple_fields{tf_it});
                p.(tuple_fields{tf_it}) = select_param(list, p_ind{f_it});
            end
        else
            list = p_list.(field);
            p.(fields{f_it}) = select_param(list, p_ind{f_it});
        end
    end
    p_out{p_indx} = p;
end
if numel(p_it) == 1
    p_out = p_out{1};
end
end % END FUNCTION

function param = select_param(list, p_it)
if iscell(list)
    param = list{p_it};
else
    param = list(p_it);
end
end
