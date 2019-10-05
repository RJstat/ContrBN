function m = lr(n,i,k)

% LR    Produces retriever matrix

% $Id: lr.m 7 2010-04-09 12:11:31Z hsqi $

if nargin <= 2
	k = 2;
end
if nargin <= 1
	i = 1;
end
if nargin == 0
	n = 2;
end
if n < 0
	error('Input argument must be positive integers.')
end

m = lm;
m.n = k;

v = repmat(1:k,k^(n-i),k^(i-1));
v = (v(:))';
m.v = v;