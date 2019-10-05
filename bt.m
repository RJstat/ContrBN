function B=bt(A,s,t)

% BT    Perform block transpose
%
%   B = BT(A,S,T)
%
%   Example: a = round(rand(3,4)*10), b = bt(a,1,2)

% $Id: bt.m 15 2013-01-14 16:51:38Z hsqi $

[m,n]=size(A);
if mod(m,s)~=0 | mod(n,t)~=0
    error('The dimensions of the first argument do not meet the conditions of block transpose.');
end
p=m/s;
q=n/t;
B=zeros(s*q,t*p);
if isa(A,'sym')
    B=sym(B);
end
for i=1:p
    for j=1:q
        B((j-1)*s+1:j*s,(i-1)*t+1:i*t)=A((i-1)*s+1:i*s,(j-1)*t+1:j*t);
    end
end