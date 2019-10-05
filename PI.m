function b = PI(L)

% PI    Produces the incidence matrix

% $Id: PI.m 15 2013-01-14 16:51:38Z hsqi $

N = round(log2(length(L))/log2(2)); % number of nodes
S = br(N);
b = zeros(N);
for i=1:N
    b(:,i) = xor(S*double(L),S*double(L*(leye(2^(i-1))+lmn(2))))*ones(2^N,1)|0;
end