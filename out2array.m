function [e, fields] = out2array(out, p_list, val_field, fields)
% organize results of a parameter sweep which was done using linear indexing
% produced by param_linearize.m into a matrix
% Inputs:
%    out : struct array where each element contains results for a param config
%    p_list : struct array of the form p_list.param_i = [ params to sweep]
%    val_field : name of field to get values from (eg. error)
%    fields : list of fields. the resulting output array will have its indices
%             matching the order of this list. if the list doesn't contain all
%             non-singleton parameter fields, the remaining ones will be added
%
% Outputs:
%    e : output matrix
%    fields : field names for each dimension of e

if ~exist('fields', 'var')
    fields = [];
elseif ~iscell(fields)
    fields = {fields};
end

all_fields = fieldnames(p_list);
n_params = struct_numel(p_list);
is_in_list = zeros(1, numel(all_fields));

% determine which fields were specified by the user
for f_it = 1:numel(fields)
    ind = get_field_ind(p_list, fields{f_it});
    if is_in_list(ind) > 0
        error('Repeated field.');
    end
    is_in_list(ind) = 1;
end
is_in_list(n_params == 1) = 1;

% assemble a list 'fields' containing:
% [<user specified fields> <remaining non-singleton fields>]
remaining_fields = all_fields(~is_in_list);
fields = [fields remaining_fields];

% create map to convert indices in order specified by 'fields' to the order
% specified by the p_list
n_fields = numel(fields);
field_ind = zeros(n_fields, 1);
for f_it = 1:n_fields
    field_ind(f_it) = get_field_ind(p_list, fields{f_it});
end

% form output matrix
if n_fields == 1
    e = zeros(n_params(field_ind), 1);
else
    e = zeros(n_params(field_ind));
end
n_total_params = prod(n_params);
for p_it = 1:n_total_params
    % get cell array of individual indices of each field corresponding to p_it
    [~, p_ind] = param_linearize(p_list, p_it);

    % translate indices into the order spcified by fields
    p_ind = p_ind(field_ind);

    % write to output array
    e(p_ind{:}) = out{p_it}.(val_field);
end
