function s = v2s (v, k, islm)
% V2S    Convert vector form to scalar form
%
%   S = V2S(V)    2-valued logic
%   S = V2S(V,K)  k-valued logic
%
%   Example: v = lm(3,8), s = v2s(v,2)

% $Id: v2s.m 18 2013-01-14 18:47:25Z hsqi $

if nargin == 1
    k = 2;
    islm = 0;
elseif nargin == 2
	islm = 0;
end

if ~isa(v,'lm'), error('The first argument must be a lm object'); end
[m,n] = size(v);
% if n ~= 1
	% error('The first argument must be a column vector')
% end

% if isa(v,'lm')
	% l = v.n;
	% p = v.v;
% else
	% l = length(v);
	% p = find(v==1);
% end

l = v.n;
p = v.v;
m = round(log2(l)/log2(k));
if n==1
	s = zeros(1,m);
	t = dec2any(p - 1, k);
	s(m-length(t)+1:end) = t;
	s = k - s - 1;
else
	s = zeros(n,m);
	for i=1:n
		s(i,:) = v2s(v(i),k);
	end
end

if islm
	s = lm(k-s,k);
end
