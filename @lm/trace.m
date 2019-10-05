function result = trace(obj)
% LM/TRACE    overloaded trace for lm class

% $Id: trace.m 13 2010-12-27 14:29:56Z hsqi $

if ~issquare(obj)
  error('LM:trace','LM object must be square');
end
result = sum(diag(obj));