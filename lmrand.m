function c=lmrand(m,n)

% LMRAND    Alias of m-function RANDLM

% $Id: lmrand.m 7 2010-04-09 12:11:31Z hsqi $

if nargin==1
    n = m;
end

c = randlm(m,n);
