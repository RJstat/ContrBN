function X = uminus(M)
% STP/UMINUS    overloaded uminus for stp class

% $Id: uminus.m 7 2010-04-09 12:11:31Z hsqi $

X = stp;
X.c = -M.c; 