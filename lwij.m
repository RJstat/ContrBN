function w = lwij(m,n)
% LWIJ    Produces swap matrix, return an LM object
%
%   A = LWIJ(N) produces an N^2-by-N^2 swap matrix.
%   A = LWIJ(M,N) produces an MN-by-MN swap matrix.
%
%   Examples: w = lwij(2,3)

% $Id: lwij.m 7 2010-04-09 12:11:31Z hsqi $

if nargin == 1
    n = m;
end

w = lm;
w.n = m*n;

M = 1:m;
N = 1:n;
i = M(ones(1,n),:);
i = (i(:))';
j = repmat(N,1,m);
w.v = i+(j-1)*m;
