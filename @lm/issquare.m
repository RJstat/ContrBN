function result = issquare(obj)
% LM/ISSQUARE    issquare method for lm class

% $Id: issquare.m 13 2010-12-27 14:29:56Z hsqi $

[m,n] = size(obj);
result = (m==n);