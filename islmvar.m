function r = islmvar(s)

% ISLMVAR   Is a string a logical matrix variable
%
% In the STP toolbox, a string initialized with a capital M which length is larger 
% than 1 is defined as a logical matrix, otherwise it is considered as a logical variable.
%
% Example: r = islmvar('M'), r = islmvar('Mf'), r = islmvar('a')

% $Id: islmvar.m 22 2013-01-19 07:56:49Z hsqi $

if iscell(s),
	r = cell(size(s));
	for i = prod(size(s)):-1:1, r{i} = islmvar(s{i}); end
    return;
end
if ~ischar(s), error('The input argument must be a string'); end
r = length(s) >= 2 & s(1) == 'M';