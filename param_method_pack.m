function p_list = param_method_pack(p_list, p_global)
% To each field in p_list (which is a struct for a given method), merge the
% fields from p_global

methods = fieldnames(p_list);
global_fields = fieldnames(p_global);

for m_it = 1:numel(methods)
    method = methods{m_it};
    for f_it = 1:numel(global_fields) % append global parameters
        fname = global_fields{f_it};
        if isptuple(p_global, fname)
            tuple_fields = fieldnames(p_global.(fname));
            for tf_it = 1:numel(tuple_fields)
                p_list.(method).(fname).(tuple_fields{tf_it}) = ...
                    p_global.(fname).(tuple_fields{tf_it});
            end
        else
            p_list.(method).(fname) = p_global.(fname);
        end
    end
end