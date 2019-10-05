function result = mtimes(a,b)
% LM/MTIMES    mtimes is overloaded by semi-tensor product for lm class

% $Id: mtimes.m 13 2010-12-27 14:29:56Z hsqi $

result = lm;
a = lm(a);
b = lm(b);
[m,n] = size(a);
[p,q] = size(b);

if n == 0 || q == 0
    error('LM:mtimes','Empty lm object');
end

if n == p
    result.v = a.v(b.v);
    result.n = a.n;
elseif mod(n,p) == 0
    k = n/p;
    r = reshape(a.v,k,p);
    r = r(:,b.v);
    r = r(:);
    result.v = r';
    result.n = a.n;
elseif mod(p,n) == 0
    if n == 1
        result.v = (a.v(1)-1)*p + b.v;
        result.n = p*m;
    else
        k = p/n;
        x = floor((b.v - 1) / k) + 1;
        t = mod(b.v,k);
        y = t+(t==0)*k;
        result.v = (a.v(x)-1)*k + y;
        result.n = m*p/n;
    end
else
    error('LM:mtimes','dimensions must match multiple dimension condition');
end;