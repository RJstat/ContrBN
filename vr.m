function v = vr(A)
% VR    Produces row stacking form of a matrix
%
%   V = VR(A) produces a vector from the matrix A row by row.

% $Id: vr.m 7 2010-04-09 12:11:31Z hsqi $

A = A';
v = A(:);