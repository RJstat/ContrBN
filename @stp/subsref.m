function B = subsref(A,S)
% STP/SUBSREF    subsref method for stp class

% $Id: subsref.m 7 2010-04-09 12:11:31Z hsqi $

A = stp(A);
B = stp;
switch S.type
case '()'
    try
        B.c = A.c(S.subs{:});
    catch
        error(' Index exceeds matrix dimensions.');
    end
case '{}'
    error('Cell array indexing not supported by STP objects');
case '.'
    error('Structure array field not supported by STP objects');
end