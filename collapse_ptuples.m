function list = collapse_ptuples(p_list)
% given a p_list, return the field names, replacing any ptuples with their first
% numerical sub-field
fields = fieldnames(p_list);
list = fields;
for f_it = 1:numel(fields)
    field = fields{f_it};
    if isptuple(p_list, field)
        tuple_fields = fieldnames(p_list.(field));
        for t_it = 1:numel(tuple_fields)
            tuple_field = tuple_fields{t_it};
            if isnumeric(p_list.(field).(tuple_field))
                list{f_it} = tuple_field;
                break;
            end
        end
    end
end