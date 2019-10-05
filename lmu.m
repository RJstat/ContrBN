function m = lmu(p,q,type)

% LMU(p,q,type)    Produces dummy logical matrix, return an LM object
%
%   If "type" is 0, LMU will produce a rear-maintaining operator, and if 1 a
%   front-maintaining operator. 
%
%   Given two logical variables X\in D_{p}, Y\in D_{q},
%   if M = lmu(p,q,1), then M*X*Y=X;
%   if M = lmu(p,q,0) or lmu(p,q), then M*X*Y=Y.
%
%   Example: m = lmu, m = lmu(2), m = lmu(3,4), m = lmu(3,4,1)

% $Id: lmu.m 26 2013-03-07 23:45:15Z hsqi $

if nargin == 0 % no arguments
	p = 2;
    q = 2;
    type = 0;
elseif nargin == 1 % one argument is given
    q = p;
    type = 0;
elseif nargin == 2 % two arguments are given
    type = 0;
end

if type % front-maintaining operator
    m = repmat(1:p,q,1);
    m = lm(m(:)',p);
else    % rear-maintaining operator
    m = lm(repmat(1:q,1,p),q);
end
