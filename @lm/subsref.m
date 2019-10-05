function result = subsref(obj,index)
% LM/SUBSREF    overloaded subsref method for lm class

% $Id: subsref.m 12 2010-12-27 09:59:51Z hsqi $

indexL = length(index);

switch index(1).type
case '.'
    try
        if indexL==1,
            result = get(obj,index(1).subs);
        else
            result = subsref(get(obj,index(1).subs),index(2:end));
        end
    catch E
        throw(E)
    end
case '()'
    try
        if indexL==1,
            result = lm;
            result.n = obj.n;
            result.v = obj.v(index(1).subs{:});
        else
            result = subsref(subsref(obj,index(1)),index(2:end));
        end
    catch E
        throw(E)
    end
case '{}'
    error('LM:subsref','Cell array indexing not supported by lm objects');
end