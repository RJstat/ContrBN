function r = strrepeat(s,n)

% STRREPEAT    Repeat a string with given times

% $Id: strrepeat.m 17 2013-01-14 17:51:23Z hsqi $

r = '';
for i=1:n, r = [r,s]; end