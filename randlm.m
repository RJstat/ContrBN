function c=randlm(m,n)

% RANDLM    Produces an m-by-n logical matrix randomly, return an LM object
%
%   C = RANDLM(M,N) produces m-by-n logical matrix
%   C = RANDLM(N) produces n-by-n logical matrix
%
%   Example: c = randlm(4,2)
%            c = randlm(4)

% $Id: randlm.m 7 2010-04-09 12:11:31Z hsqi $

if nargin==1
    n = m;
end

c = lm;
c.n = m;
c.v = ceil(rand(1,n)*m);
