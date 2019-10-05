function A = invvc(x,m)
% INVVC    Inverse of VC
%
%   A = INVVC(X,M) creates an M-row matrix from the vector X.
%
%   Example: a = invvc(1:12)
%            a = invvc(1:12,3)

% $Id: invvc.m 7 2010-04-09 12:11:31Z hsqi $

x = x(:);
l = length(x);
if nargin == 1
    m = ceil(sqrt(l));
    if m^2-1 ~= 1
        l=m^2;
        x(l)=0;
    end
else
    r=mod(l,m);
    if r~=0
        l = l+m-r;
        x(l)=0;
    end
end
A=reshape(x,m,l/m);
