function result = isempty(obj)
% LM/ISEMPTY    overloaded isempty method for lm class

% $Id: isempty.m 13 2010-12-27 14:29:56Z hsqi $

result = isempty(obj.v);