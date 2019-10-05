function c = rightsp(a,b)
% RIGHTSP    Right Semi-Tensor Product of Matrices using Kronecker product
%
%   RIGHTSP(A,B) is to calculate the right semi-tensor product of A and B.
%   The number of columns of the fisrt matrix must be the divisor
%   or multiple of the number of rows of the last matrix.

% $Id: rightsp.m 15 2013-01-14 16:51:38Z hsqi $

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
    c = a*kron(eye(z),b);
elseif mod(p,n) == 0
    z = p/n;
    c = zeros(m*z,q);
    c = kron(eye(z),a)*b;
else
    error('The input arguments do not meet the multiple dimension matching condition.');
end;