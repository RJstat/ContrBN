function c = sp(a,b)
% SP    (Left) Semi-Tensor Product of Matrices using Kronecker product
%
%   SP(A,B) is to calculate the (left) semi-tensor product of A and B.
%   The two matrices must meet the multiple dimension matching condition,
%   i.e., the number of columns of the fisrt matrix must be the divisor
%   or multiple of the number of rows of the last matrix.

if ~(isa(a,'sym') | isa(a,'double'))
    a = double(a);
end
if ~(isa(b,'sym') | isa(b,'double'))
    b = double(b);
end

if ndims(a) > 2 | ndims(b) > 2
    error('Input arguments must be 2-D.');
end

[m,n] = size(a);
[p,q] = size(b);
if n == p
    c = a*b;
elseif mod(n,p) == 0
    z = n/p;
    c = zeros(m,z*q);
    c = a*kron(b,eye(z));
elseif mod(p,n) == 0
    z = p/n;
    c = zeros(m*z,q);
    c = kron(a,eye(z))*b;
else
    error('The input arguments do not meet the multiple dimension matching condition.');
end;