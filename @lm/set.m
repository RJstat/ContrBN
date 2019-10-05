function obj = set(obj,varargin)
% LM/SET    set LM properties and return the updated object

% $Id: set.m 13 2010-12-27 14:29:56Z hsqi $

property_argin = varargin;
while length(property_argin) >= 2,
    prop = property_argin{1};
    val = property_argin{2};
    property_argin = property_argin(3:end);
    switch prop
    case {'v','value'} % 'value' is for compatibility with older versions
		if ~all(val > 0) || obj.n < max(val)
			warning(['Invalid value [' num2str(val) '] for property v'])
            continue
		end
        obj.v = val(:).';
    case {'n','dim','len'} % 'dim' and 'len' are for compatibility with older versions
		if val < 0 || val < max(obj.v)
			warning(['Invalid value ''' num2str(val) ''' for property n'])
            continue
		end
        obj.n = val;
    otherwise
        error('LM:set','LM properties: v, n!')
    end
end