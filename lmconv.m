function r = lmconv(L,k)
% LMCONV   Convert a network transition matrix to its component-wise forms
%
%

% $Id: lmconv.m 25 2013-01-31 18:48:28Z hsqi $

if nargin == 1, k = 2; end;
[p,q] = size(L);
if p ~= q, error('The first input argument must be a square matrix.'); end;

n = floor(log2(p+0.5)/log2(k));

s = zeros(p,n);
for i=1:q
    s(i,:) = v2s(L(i),k);
end
s = k-s';

r = cell(n,1);
for i=1:n
    r{i} = lm(s(i,:),k);
end
