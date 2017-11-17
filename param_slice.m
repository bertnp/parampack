function p_it = param_slice(p_list, fields, inds)
%PARAM_SLICE convert (field, ind) pairs to linear index
%
% Example: suppose the struct p has the fields
%   f1 : [5 x 1 double]
%   f2 : [3 x 1 double]
%   f3 : [6 x 1 double]
% Then the linear index of the parameter configuration f1(2), f2(3), f3(1) is
% given by PARAM_SLICE(p, 'f1', 2, 'f2', 3, 'f3', 1);
%
% Fields that are not specified are assigned a value of 1.

siz = struct_numel(p_list);
all_fields = fieldnames(p_list);

% n_fields = floor((nargin-1)/2);
n_fields = numel(fields);

%fields = varargin(1:2:end);
if ~iscell(fields)
    fields = {fields};
end
%inds = varargin(2:2:end);

full_ind = ones(numel(all_fields), 1);
for fs_it = 1:n_fields
    ind = get_field_ind(p_list, fields{fs_it});
    if isempty(ind)
        error('Specified field does not exist in parameter struct.');
    end
    full_ind(ind) = inds(fs_it);
end
full_ind = num2cell(full_ind);

p_it = sub2ind(siz, full_ind{:});
end

