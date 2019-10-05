function c = anysp(a,b)

% ANYSP    (Left) Semi-Tensor Product of Arbitrary Matrices Using Kronecker Product
%
%   ANYSP(A,B) is to calculate the left semi-tensor product of A and B.
%   The dimensions of the matrices could be arbitrary.

% $Id: anysp.m 15 2013-01-14 16:51:38Z hsqi $

if ~(isa(a,'sym') || isa(a,'double'))
    a = double(a);
end
if ~(isa(b,'sym') || isa(b,'double'))
    b = double(b);
end

if ndims(a) > 2 || ndims(b) > 2
    error('Input arguments must be 2-D.');
end

n = size(a,2); % get the number of columns
p = size(b,1); % get the number of rows
z = lcm(n,p);
c = kron(a,eye(z/n))*kron(b,eye(z/p));