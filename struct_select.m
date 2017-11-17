function [ out ] = struct_select( s, f )
% struct_select(struct, field)
%
% Input:  an array of structs
% Output: array of doubles formed by taking the specified field out of struct

out = zeros(size(s));
for ii = 1:numel(s)
   out(ii) = s{ii}.(f);
end

end

