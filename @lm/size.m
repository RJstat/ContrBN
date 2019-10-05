function [m,n] = size(obj,dim)
% LM/SIZE    overloaded size for lm class

% $Id: size.m 14 2013-01-14 14:45:44Z hsqi $

if (nargin == 2 && nargout > 1) || (nargin == 1 && nargout > 2)
    error('LM:size','Too many output arguments')
end
if nargin == 1
    if nargout == 2
        m = obj.n;
        n = length(obj.v);
    else
        m = [obj.n,length(obj.v)];
    end
else
    if dim == 1
        m = obj.n;
    elseif dim == 2
        m = length(obj.v);
    else
        error('LM:size','Invalid second input argument')
    end
end