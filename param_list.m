function list = param_list(p_list, field)
fields = fieldnames(p_list);
[ind, isintuple] = get_field_ind(p_list, field);
if isptuple(p_list, field)
    tuple_fields = fieldnames(p_list.(field));
    list = p_list.(field).(tuple_fields{1});
elseif isintuple > 0
    list = p_list.(fields{ind}).(field);
else
    list = p_list.(field);
end