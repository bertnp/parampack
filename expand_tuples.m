function list = expand_tuples(p_list, fields)
% given a p_list and list of fields, resolve any elements in fields which are
% sub-fields back to their parent tuple
all_fields = fieldnames(p_list);

list = [];
list{numel(fields)} = [];
for f_it = 1:numel(fields)
    field = fields{f_it};
    ind = get_field_ind(p_list, field);
    list{f_it} = all_fields{ind};
end
    