function m = lmd(k)

% LMD    Produces logical matrix for disjunction, return an LM object
%
%   M = LMD     for classical logic
%   M = LMD(K)  for k-valued logic
%
%   Example: m = lmd, m = lmd(2)

% $Id: lmd.m 7 2010-04-09 12:11:31Z hsqi $

if nargin == 0 | isempty(k)
	k = 2;
end

m = lm;
m.n = k;

a = 1:k;
p = a(ones(1,k),:);
p = (p(:))';
q = repmat(a,1,k);
b = p<=q;
m.v = p.*b+q.*~b;
