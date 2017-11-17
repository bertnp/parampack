function i_out = param_translate(p_in, i_in, p_out)
%PARAM_TRANSLATE translate linear indices between parameter lists
% Example:
%   p1 has fields a,b,c,d
%   p2 has fields c,b
%  i_out is the linear index for p_out which gives the same parameter
%  configuration for c and b as the linear index i_in for parameter list p_in

fields_in = fieldnames(p_in);
fields_out = fieldnames(p_out);

siz_in = struct_numel(p_in);
siz_out = struct_numel(p_out);
[inds_in{1:numel(fields_in)}] = ind2sub(siz_in, i_in);
inds_out = ones(numel(fields_out), 1);
for ii = 1:numel(fields_out)
    f_ind = get_field_ind(p_in, fields_out{ii}, [], p_out);
    if ~isempty(f_ind)
        inds_out(ii) = inds_in{f_ind};
    end
end
inds_out = num2cell(inds_out);
i_out = sub2ind(siz_out, inds_out{:});
