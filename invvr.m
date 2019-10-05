function A = invvr(x,n)
% INVVC    Inverse of VR
%
%   A = INVVR(X,N) produces an N-row matrix from the vector X.
%
%   Example: a = invvr(1:12)
%            a = invvr(1:12,3)

% $Id: invvr.m 7 2010-04-09 12:11:31Z hsqi $

if nargin == 1
    A=invvc(x);
else
    A=invvc(x,n);
end
A=A';