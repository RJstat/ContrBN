function m = lmc(k)

% LMC    Produces logical matrix for conjunction, return an LM object
%
%   M = LMC     for classical logic
%   M = LMC(K)  for k-valued logic
%
%   Example: m = lmc, m = lmc(2)

% $Id: lmc.m 7 2010-04-09 12:11:31Z hsqi $

if nargin == 0 | isempty(k)
	k = 2;
end

m = lm;
m.n = k;

a = 1:k;
p = a(ones(1,k),:);
p = (p(:))';
q = repmat(a,1,k);
b = p>=q;
m.v = p.*b+q.*~b;
