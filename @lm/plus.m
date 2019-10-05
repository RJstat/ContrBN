function result = plus(a,b)
% LM/PLUS    plus is overloaded by the Kronecher product for lm class

% $Id: plus.m 13 2010-12-27 14:29:56Z hsqi $

result = kron(a,b);