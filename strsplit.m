function r = strsplit(s, sep)

% STRSPLIT    Split a string by string
%
%    Usage: r = strsplit(s, sep) will split "s" by "sep", and it return a cell array "r". 
%           The second argument "sep" is optional, default is a blank.
%
%    Example: r = strsplit('Hello World! This is an example.')

% $Id: strsplit.m 20 2013-01-19 07:34:08Z hsqi $

if nargin==1, sep = ' '; end;
r = {};
s = deblank(s);
i = 1;
while any(s)
	[chopped,s] = strtok(s, sep);
	if length(chopped)>0 
		r{i} = chopped;
		i = i + 1;
	end
end
