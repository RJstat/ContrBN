function v = dec2bin (a,len)

% DEC2BIN    Convert a decimal number to binary as a vector of a given length
%
%   Example: v = dec2bin(11)
%            v = dec2bin(11,6)

% $Id: dec2bin.m 17 2013-01-14 17:51:23Z hsqi $

if nargin == 1
    len = 0;
end
v = dec2any(a,2,len);
