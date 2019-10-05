function C = mtimes(A,B)
% STP/MTIMES   mtimes is overloaded by semi-tensor product for stp class

% $Id: mtimes.m 7 2010-04-09 12:11:31Z hsqi $

A = stp(A);
B = stp(B);
C = stp;
[m,n] = size(A);
[p,q] = size(B);
if n == p
    C = stp(A.c*B.c);
elseif mod(n,p) == 0
    z = n/p;
    C.c = zeros(m,z*q);
    C.c = A.c*kron(B.c,eye(z));
elseif mod(p,n) == 0
    z = p/n;
    C.c = zeros(m*z,q);
    C.c = kron(A.c,eye(z))*B.c;
else
    error('dimension error: mtimes');
end;