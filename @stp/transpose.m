function B = transpose(A)
% STP/TRANSPOSE    overloaded transpose for stp class

% $Id: transpose.m 7 2010-04-09 12:11:31Z hsqi $

B = stp;
B.c = A.c';