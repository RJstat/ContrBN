function result = kron(a,b)
% LM/KRON    Kronecher product for lm class

% $Id: kron.m 13 2010-12-27 14:29:56Z hsqi $

a = lm(a);
b = lm(b);
result = lm;

[m,n] = size(a);
[p,q] = size(b);

r = (a.v - 1)*p;
r = ones(q,1)*r;
r = r + (b.v)'*ones(1,n);
result.v = r(:)';
result.n = m*p;