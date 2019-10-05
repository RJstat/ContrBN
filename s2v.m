function v = s2v (s,k)

% S2V    Convert scalar form to vector form, return an LM object
%
%   V = S2V(S)    for 2-valued logic
%   V = S2V(S,K)  for k-valued logic
%
%   Example: v = s2v([1 0 1],2)

% $Id: s2v.m 7 2010-04-09 12:11:31Z hsqi $

if nargin == 1
    k = 2;
end

[m,n] = size(s);
v = lm;
v.n = k^n;

if m > 1
    value = ones(1,m);
    for i = 1:m
        v0 = s2v(s(i,:),k);
        value(i) = v0.v;
    end
    v.v = value;
else

    if all(size(find(s<0 | s>=k)))
        error('The first input argument is invalid');
    end

    s = k - s;
    v.v = sum(k.^((n-1):-1:0).*(s-1))+1;
end

