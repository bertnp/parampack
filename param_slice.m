function p_it = param_slice(p_list, in_fields, in_inds)
%PARAM_SLICE convert (field, ind) pairs to linear index
%
% Example: suppose the struct p has the fields
%   f1 : [5 x 1 double]
%   f2 : [3 x 1 double]
%   f3 : [6 x 1 double]
% Then the linear index of the parameter configuration f1(2), f2(3), f3(1)
% is given by PARAM_SLICE(p, {'f1', 'f2',  'f3'}, [2 3 1]);
%
% in_inds can be a cell array whose entries are lists of indices for each
% field
%
% If any fields are not specified, p_it will contain all the possible
% indexes of unassigned fields

siz = struct_numel(p_list);
fields = fieldnames(p_list);
n_fields = numel(fields);
n_in_fields = numel(in_fields);
if ~iscell(in_inds)
    in_inds = num2cell(in_inds);
end

if ~iscell(fields)
    in_fields = {in_fields};
end

%% make a list of the indices to slice for each field
% start by fixing the ones which are specified
inds = cell(n_fields, 1);
for f_it = 1:n_in_fields
    field_ind = get_field_ind(p_list, in_fields{f_it});
    inds{field_ind} = in_inds{f_it};
end

% then set unspecified fields to return all indices
for f_it = 1:n_fields
    if isempty(inds{f_it})
        inds{f_it} = 1:siz(f_it);
    end
end

%% determine the linear index for each element in the slice
slice_siz = cell_numel(inds);
n_slice = prod(slice_siz);
p_it = zeros(1, n_slice);

for s_it = 1:n_slice
    slice_inds = cell(1, n_fields);
    [slice_inds{1:n_fields}] = ind2sub(slice_siz, s_it);
    slice = cell(1, n_fields);
    for ii = 1:n_fields
        slice{ii} = inds{ii}(slice_inds{ii});
    end
    p_it(s_it) = sub2ind(siz, slice{:});
end
end

function siz = cell_numel(in)
n = numel(in);
siz = zeros(1, n);
for ii = 1:n
    siz(ii) = numel(in{ii});
end
end

