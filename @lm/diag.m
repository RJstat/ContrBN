function result = diag (obj)
% LM/DIAG    overloaded diag for lm class

% $Id: diag.m 13 2010-12-27 14:29:56Z hsqi $

n = min(size(obj));
result = (1:n == obj.v(1:n));
