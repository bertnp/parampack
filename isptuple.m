function out = isptuple(p, field)
out = ~isempty(strfind(field, 'ptuple')) && isstruct(p.(field));