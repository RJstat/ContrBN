function C = times(A,B)
% STP/TIMES    overloaded times for stp class

% $Id: times.m 7 2010-04-09 12:11:31Z hsqi $

A = stp(A);
B = stp(B);
C = stp;
if all(size(A) == size(B))
    C.c = A.c.*B.c;
else
    error('Matrix dimensions must agree.');
end