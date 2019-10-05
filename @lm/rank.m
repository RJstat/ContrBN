function result = rank(obj)
% LM/RANK    overloaded rank for lm class

% $Id: rank.m 13 2010-12-27 14:29:56Z hsqi $

result = length(unique(obj.v));