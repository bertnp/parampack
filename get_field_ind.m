function [ind, isintuple] = get_field_ind(p_list, field, fields, s_list)
% find the index in fields corresponding to field
% - field may be a sub-field, or contain sub-fields in source_list. if this is the case, field
%   is replaced with a list containing the parent and all sub-fields
% - any of the fields in field may be a sub-field or contain sub-fields in
%   p_list. if this is the case, a match should occur on the parent or any
%   sub-fields.
% see demo file for examples



if ~exist('s_list', 'var') || isempty(s_list)
    field = {field};
else % add aliases from s_list
    s_fields = fieldnames(s_list);
    s_ind = get_ind(s_list, field);
    s_field = s_fields{s_ind};
    if isptuple(s_list, s_field)
        s_sub_fields = fieldnames(s_list.(s_field));
        field = [ {s_field}; s_sub_fields];
    else
        field = {field};
    end
    
end

if ~exist('fields', 'var') || isempty(fields)
    fields = fieldnames(p_list);
end
[ind, isintuple] = get_ind(p_list, field, fields);

end


function [ind, isintuple] = get_ind(s_list, field, fields)
if ~exist('fields', 'var') || isempty(fields)
    fields = fieldnames(s_list);
end

ind = [];
isintuple = 0;
for af_it = 1:numel(fields)
    af_field = fields{af_it};
    
    % field might be a field in fieldnames(p_list)
    if any(strcmp(af_field, field))
        ind = af_it;
        break;
    end
    
    % or field might be in one of the tuples in p_list
    if isptuple(s_list, af_field)
        tuple_fields = fieldnames(s_list.(af_field));
        for tf_it = 1:numel(tuple_fields)
            tf_ind = strcmp(tuple_fields{tf_it}, field);
            if any(tf_ind)
                isintuple = 1;
                ind = af_it;
                break;
            end
        end
    end
end
end