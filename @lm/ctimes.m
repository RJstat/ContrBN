function result = ctimes(a,b,varargin)
% LM/CTIMES    ctimes method for lm class

% C=CTIMES(A,B,...) 

% $Id: ctimes.m 13 2010-12-27 14:29:56Z hsqi $

a = lm(a);
b = lm(b);

if isempty(a) || isempty(b)
    error('LM:ctimes','Empty lm object');
end

if length(a) ~= length(b)
    error('LM:ctimes','The column numbers must agree');
end;

result = lm;
result.n = a.n*b.n;
aL = length(a);
v = zeros(1,aL);
for i = 1:aL
    v(i) = (a.v(i)-1)*b.n + b.v(i);
end;
result.v = v;

l = length(varargin);
if l > 0
    result = ctimes(result,varargin{:});
end