function [s,varargout] = size(M,dim)
% STP/SIZE    overloaded size for stp class

% $Id: size.m 14 2013-01-14 14:45:44Z hsqi $

if (nargin == 1)
    s = size(M.c);
elseif (nargin == 2)
    s = size(M.c,dim);
end
nout = max(nargout,1)-1;
if (nout > 0) && (nargin == 1)
    n = length(s);
    for k=1:nout
        if (k < n)
            varargout(k) = {s(k+1)}; 
        else
            varargout(k) = {1};
        end
    end
    if (nout+1 < n)
        varargout{k} = prod(s(nout+1:n));
    end
    s = s(1);
end