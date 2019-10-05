function r = strjoin(s, glue)

% STRJOIN    Join strings by a string

% $Id: strjoin.m 20 2013-01-19 07:34:08Z hsqi $

if nargin == 1, glue = ' '; end
r = '';
l = length(s);
for i = 1:l-1, r = [r,s{i},glue]; end
r = [r,s{l}];