function A = subsasgn(A,S,B)
% STP/SUBSASGN    subsasgn method for stp class

% $Id: subsasgn.m 7 2010-04-09 12:11:31Z hsqi $

A = stp(A);
B = stp(B);

switch S.type
case '()'
    A.c(S.subs{:}) = B.c;
case '{}'
    error('Cell array indexing not supported by STP objects');
case '.'
    error('Structure array field not supported by STP objects');
end