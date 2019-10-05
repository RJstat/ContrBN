function m = lme(k)

% LME    Produces logical matrix for equivalence, return an LM object
%
%   M = LME     for classical logic
%   M = LME(K)  for k-valued logic
%
%   Example: m = lme, m = lme(2)

% $Id: lme.m 9 2010-12-22 14:32:11Z hsqi $

if nargin == 0 | isempty(k)
	k = 2;
end

Mc = lmc(k);
Mi = lmi(k);
Mr = lmr(k);

m = Mc*Mi*(leye(k^2)+Mi)*(leye(k)+Mr)*(leye(k)+lwij(k))*Mr;