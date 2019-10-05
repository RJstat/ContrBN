function B = ctranspose(A)
% STP/CTRANSPOSE    overloaded ctranspose for stp class

% $Id: ctranspose.m 7 2010-04-09 12:11:31Z hsqi $

B = stp;
B.c = A.c';