function m = br(n,i)

% BR    Produces retriever matrix in Boolean form

% $Id: br.m 15 2013-01-14 16:51:38Z hsqi $

if nargin <= 0
	error('No input arguments.')
elseif n < 0
	error('Input argument must be positive integers.')
end

if nargin <= 1
	i = 1:n;
elseif max(i) > n
	error('The maximum of the second argument cannot exceed the first argument.')
end

[dm,dn] = size(i);

if dm > 1 && dn > 1
	error('The second argument must be a scalar or vector.')
end

if dm == 1 && dn == 1
	m = repmat([1,0],2^(n-i),2^(i-1));
	m = (m(:))';
	return
end

ds = max(dm,dn);
m = zeros(ds,2^n);
for j = 1:ds
	m(j,:) = br(n,i(j));
end
