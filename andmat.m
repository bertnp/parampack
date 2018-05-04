function [ outvec ] = andmat( inmat, dim )
%ANDMAT [ outvec ] = andmat( inmat, dim )
%   Compares all the columns of the matrix using logical AND

if nargin == 1
    dim = 2;
end

if dim == 1
    inmat = inmat';
end

outvec = inmat(:,1);
for ii = 2:size(inmat,2)
    outvec = and(outvec,inmat(:,ii));
end

end

