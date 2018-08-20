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
% If any fields are not specified, p_it will contain all the possible
% indexes of unassigned fields

siz = struct_numel(p_list);
all_fields = fieldnames(p_list);

% n_fields = floor((nargin-1)/2);
n_fields = numel(fields);

%fields = varargin(1:2:end);
if ~iscell(fields)
    fields = {fields};
end
%inds = varargin(2:2:end);

if n_fields == numel(all_fields)
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
else
    enum = ind_enum(siz);
    all_ind = combvec(enum{:})';
    use_vals = zeros(size(all_ind,1),n_fields);
    for fs_it = 1:n_fields
        ind = get_field_ind(p_list, fields{fs_it});
        if isempty(ind)
            error('Specified field does not exist in parameter struct.');
        end
        use_vals(:,fs_it) = all_ind(:,ind)==inds(fs_it);
    end
    
    use_vals = andmat(use_vals);
    
    full_ind = all_ind(boolean(use_vals),:);
    p_it = size(full_ind,1);
    for ii = 1:size(full_ind,1)
        t_ind = num2cell(full_ind(ii,:));
        p_it(ii) = sub2ind(siz,t_ind{:});
    end
end
end

