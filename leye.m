function m = leye(n)

% LEYE    Create an n-by-n identity matrix, return an LM object
%
%   M = LEYE(N)
%
%   Example: m = leye(3), class(m)

% $Id: leye.m 9 2010-12-22 14:32:11Z hsqi $

if n < 0
	error('Input argument must be a positive integer')
end

m = lm(1:n,n);
