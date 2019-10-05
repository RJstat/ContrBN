function B = mpower(A,p)
% STP/MPOWER    overloaded mpower for stp class

% $Id: mpower.m 14 2013-01-14 14:45:44Z hsqi $

A = stp(A);
if all(size(p)==1)
    if p >= 0 && p == floor(p)
        if p == 0
            B = stp(1);
        elseif p == 1
            B = A;
        else
            B = A*A^(p-1);
        end
    else
        error('The second operand must be a non negative integer.');
    end
else
    error('The second operand must be a scalar.');
end