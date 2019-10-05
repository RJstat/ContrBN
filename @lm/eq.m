function result = eq(a,b)
% LM/EQ    overloaded eq for lm class

% $Id: eq.m 14 2013-01-14 14:45:44Z hsqi $

result = [];
if isa(a,'lm') && isa(b,'lm')
	if a.n ~= b.n
		error('LM:eq','The column numbers must agree');
	end
	result = (a.v==b.v);
elseif isa(a,'lm') || isa(b,'lm')
	if isa(a,'lm')
		result = (a.v == b);
	else
		result = (a == b.v);
	end
end