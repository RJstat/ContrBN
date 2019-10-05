function c = lsp(a,b)

% LSP    (Left) Semi-tensor product for logical matrices, return an LM object
%
%   LSP(A,B) is to calculate the (left) semi-tensor product of two logical matrices A and B.
%   The number of columns of the fisrt matrix must be the divisor
%   or multiple of the number of rows of the last matrix.

% $Id: lsp.m 14 2013-01-14 14:45:44Z hsqi $

c = lm;
a = lm(a);
b = lm(b);

c = a*b;