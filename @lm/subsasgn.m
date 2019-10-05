function obj = subsasgn(obj,index,val)
% LM/SUBSASGN    overloaded subsasgn method for lm class

% $Id: subsasgn.m 17 2013-01-14 17:51:23Z hsqi $

switch index.type
case '()'
	switch index.subs{:}
		case 1
			if ~all(val > 0) | obj.n < max(val)
				error('LM:subsasgn','Invalid value')
			end
			obj.v = val(:).';
		case 2
			if val < 0 | val < max(obj.v)
				error('LM:subsasgn','Invalid value')
			end
			obj.n = val;
		otherwise
			error('LM:subsasgn','Index out of range')
	end
case '.'
	switch index.subs
		case {'v','value'}
			if ~all(val > 0) | obj.n < max(val)
				error('LM:subsasgn','Invalid value')
			end
			obj.v = val(:).';
		case {'n','dim','len'}
			if val < 0 | val < max(obj.v)
				error('LM:subsasgn','Invalid value')
			end
			obj.n = val;
		otherwise
			error('LM:subsasgn','Invalid field name')
    end
end