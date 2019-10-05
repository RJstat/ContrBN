function C = minus(A,B)
% STP/MINUS    overloaded minus for stp class

% $Id: minus.m 7 2010-04-09 12:11:31Z hsqi $

A = stp(A);
B = stp(B);
C = stp;
if all(size(A) == size(B))
    C.c = A.c-B.c;
else
    error('Matrix dimensions must agree.');
end