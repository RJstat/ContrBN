function m = lmn(k);

% LMN    Produces logical matrix for negation, return an LM object
%
%   M = LMN     for classical logic
%   M = LMN(K)  for k-valued logic
%
%   Example: m = lmn, m = lmn(2)

% $Id: lmn.m 9 2010-12-22 14:32:11Z hsqi $

if nargin == 0 | isempty(k)
	k = 2;
end

m = lm(k:-1:1,k);
