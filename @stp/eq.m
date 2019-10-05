function r = eq(A,B)
% STP/EQ    overloaded eq for stp class

r = [];
if isa(A,'stp') && isa(B,'stp')
	r = (A.c == B.c);
elseif isa(A,'stp') || isa(B,'stp')
	if isa(A,'stp')
		r = (A.c == B);
	else
		r = (A == B.c);
	end
end
