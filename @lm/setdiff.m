function result = setdiff(a,b)
% LM/SETDIFF    overloaded setdiff method for lm class

% $Id: setdiff.m 13 2010-12-27 14:29:56Z hsqi $

a = lm(a);
b = lm(b);
if a.n ~= b.n
	error('LM:setdiff','The row numbers must agree')
end

result = lm;
result.n = a.n;
result.v = setdiff(a.v, b.v);