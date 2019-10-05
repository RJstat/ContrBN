function C = plus(A,B)
% STP/PLUS    overloaded plus for stp class

% $Id: plus.m 7 2010-04-09 12:11:31Z hsqi $

A = stp(A);
B = stp(B);
C = stp;

if all(size(A) == size(B))
    C.c = A.c + B.c;
else
    error('Matrix dimensions must agree.');
end