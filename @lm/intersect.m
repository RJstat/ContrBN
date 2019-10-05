function result = intersect(a,b)
% LM/INTERSECT    overloaded intersect method for lm class

% $Id: intersect.m 13 2010-12-27 14:29:56Z hsqi $

a = lm(a);
b = lm(b);
if a.n ~= b.n
	error('LM:intersect','The row numbers must agree');
end

result = lm;
result.n = a.n;
result.v = intersect(a.v, b.v);