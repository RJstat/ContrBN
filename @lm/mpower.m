function result = mpower(obj,p)
% LM/MPOWER    overloaded mpower for lm class

% $Id: mpower.m 13 2010-12-27 14:29:56Z hsqi $

obj = lm(obj);
[m,n] = size(obj);
if mod(m,n)==0 || mod(n,m)==0
    if all(size(p)==1)
        if p >= 0 && p == floor(p)
            if p == 0
                result = lm(1);
            elseif p == 1
                result = obj;
            else
                result = obj*obj^(p-1);
            end
        else
            error('LM:mpower','The second input argument must be a non negative integer');
        end
    else
        error('LM:mpower','The second input argument must be a scalar');
    end
else
    error('LM:mpower','The first input argument must match multiple dimension condition');
end