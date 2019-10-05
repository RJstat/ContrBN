function result = inv(obj)
% LM/INV    overloaded inv method for lm class

% $Id: inv.m 13 2010-12-27 14:29:56Z hsqi $

if ~issquare(obj)
    error('The input argument is not square');
end
if rank(obj)~=obj.n
    error('The input argument is not invertible');
end
result = lm;
result.n = obj.n;
result.v = ones(1,result.n);
for i=1:result.n
    result.v(i) = find(obj.v==i);
end