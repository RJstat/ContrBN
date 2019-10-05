function C = power(A,B)
% STP/POWER    overloaded power for stp class

% $Id: power.m 14 2013-01-14 14:45:44Z hsqi $

A = stp(A);
B = stp(B);
C = stp;

if all(size(A) == 1) || all(size(B) == 1) || all(size(A)==size(B))
    C.c = A.c.^B.c;
else
    error('Matrix dimensions must agree.');
end