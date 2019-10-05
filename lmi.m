function m = lmi(k)

% LMI    Produces logical matrix for implication, return an LM object
%
%   M = LMI     for classical logic
%   M = LMI(K)  for k-valued logic
%
%   Example: m = lmi, m = lmi(2)

% $Id: lmi.m 9 2010-12-22 14:32:11Z hsqi $

if nargin == 0 | isempty(k)
	k = 2;
end

Md = lmd(k);
Mn = lmn(k);

m = Md*Mn;