function n_per_field = struct_numel(p, fields)
%STRUCT_NUMEL get number of elements in each struct field
% ordering is the same as that returned by fieldnames

if ~exist('fields', 'var') || isempty(fields)
    fields = fieldnames(p);
end
n_fields = numel(fields);
n_per_field = zeros(1, n_fields); % number of parameters in each field
for f_it = 1:n_fields
    field = fields{f_it};
    if isptuple(p, field)
        tuple_fields = fieldnames(p.(field));
        n_per_field(f_it) = numel(p.(field).(tuple_fields{1}));
    else
        n_per_field(f_it) = numel(p.(fields{f_it}));
    end
end