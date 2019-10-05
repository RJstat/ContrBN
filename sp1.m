function c = sp1(a,b)

% SP1     (Left) Semi-Tensor Product of Matrices by its definition
%
%   SP1(A,B) is to calculate the left semi-tensor product of A and B.
%   The number of columns of the fisrt matrix must be the divisor
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

n = size(a,2);
p = size(b,1);
if n == p
    c = a * b;
elseif mod(n,p) == 0
    c = leftsp(a,b);
elseif mod(p,n) == 0
    c = (leftsp(b.',a.')).';
else
    error('The input arguments do not meet the multiple dimension matching condition.');
end

function r = leftsp(a,b)
[m,n] = size(a);
[p,q] = size(b);
k = n/p;
r = zeros(m,k*q);
if isa(a,'sym') | isa(b,'sym')
    r = sym(r);
end
for i = 1:m
    for j = 1:q
        r(i,((j-1)*k+1):(j*k)) = (reshape(a(i,:),k,p)*b(:,j)).';
    end
end