function r = unique(obj)
% LM/UNIQUE    overloaded unique method for lm class

% $Id: unique.m 13 2010-12-27 14:29:56Z hsqi $

result = obj;
result.v = unique(obj.v);