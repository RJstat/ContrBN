function result = double(obj)
% LM/DOUBLE    double converter for lm class

% $Id: double.m 13 2010-12-27 14:29:56Z hsqi $

[p,q] = size(obj);
result = zeros(p,q);
k = obj.v + p*(0:q-1);
result(k) = 1;