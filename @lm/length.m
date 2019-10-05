function result = length(obj)
% LM/LENGTH    overloaded length for lm class, it returns the column number of a LM object

% $Id: length.m 13 2010-12-27 14:29:56Z hsqi $

result = length(obj.v);