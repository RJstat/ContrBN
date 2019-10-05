function Mr = lmr(k)

% LMR    Produces power-reducing matrix, return an LM object
%
%   The power-reducing matrix M satisfies P^2=MP, where P is a logical variable.
%
%   M = LMR     for classical logic
%   M = LMR(K)  for k-valued logic
%
%   Example: m = lmr, m = lmr(2)

% $Id: lmr.m 9 2010-12-22 14:32:11Z hsqi $

if nargin < 2, n = 1; end;
if nargin == 0 | isempty(k), k = 2; end;

if n == 1
	a = 1:k;
	Mr = lm(a+(a-1)*k,k^2);
else
	Mr = (leye(2)+lwij(2,2^(n-1)))*lmr(k,1)*(leye(2)+lmr(k,n-1));
end
