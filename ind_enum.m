function [ enum ] = ind_enum( full_ind )
%IND_ENUM [ enum ] = ind_enum( full_ind )
%   Takes in a vector of numbers and returns a cell of the same size, in
%   which every element is 1:full_ind(indx)

enum = cell(numel(full_ind),1);
for ii = 1:numel(full_ind)
    enum{ii} = 1:full_ind(ii);
end

end

