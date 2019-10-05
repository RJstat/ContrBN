function result = get(obj,property)
% LM/GET    Get LM properties from the specified object and return the value

% $Id: get.m 13 2010-12-27 14:29:56Z hsqi $

switch property
case {'v','value'} % 'value' is for compatibility with older versions
    result = obj.v;
case {'n','dim','len'} % 'dim' and 'len' are for compatibility with older versions
    result = obj.n;
otherwise
    error('LM:get',['''',property,''' is an invalid property of LM object'])
end