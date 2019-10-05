function ind = find(obj,val,op)
% LM/FIND    overloaded find for lm class

% $Id: find.m 13 2010-12-27 14:29:56Z hsqi $

ni = nargin;
if ni < 3, op = '='; end

if isa(obj,'lm') && isa(val,'lm')
    if obj.n ~= val.n
        error('LM:find','The row numbers must agree');
    end
    l = obj.v;
    r = val.v;
else
    if isa(obj,'lm')
        l = obj.v;
        r = val;
    else
        l = obj;
        r = val.v;
    end
end

switch op
case {'=','==','eq'}
    ind = eq(l,r);
case {'>','gt'}
    ind = gt(l,r);
case {'<','lt'}
    ind = lt(l,r);
case {'>=','ge'}
    ind = ge(l,r);
case {'<=','le'}
    ind = le(l,r);
otherwise
    error('LM:find','unknown operation');
end
    