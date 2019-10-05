function r = completeeqn(eqn, opn)

% COMPLETEEQN    Add the not appeared variables to the equation compared with the complete variables set in lm option
%
% Please see example_bn06.m.

% $Id: completeeqn.m 17 2013-01-14 17:51:23Z hsqi $

if iscell(eqn),
    r = cell(size(eqn));
    for i = prod(size(eqn)):-1:1
        r{i}= completeeqn(eqn{i}, opn);
    end
    return
end
Vars = lmget(opn, 'Vars', {});
if isempty(Vars), error('Please set all variables in lm option'); end

vars = strsplit(eqn);
l = length(vars);
f = zeros(1,l);
for i = 1:l, f(i) = ~islmvar(vars{i}); end
varstr = strvcat(vars(find(f)));

c = {};
j = 0;
for i = Vars
	if isempty(strmatch(i,varstr,'exact'))
        j = j+1;
        c(j) = i;
    end
end
if ~isempty(c)
    r = [strrepeat('MU ',length(c)) strjoin(c,' ') ' ' eqn];
else
    r = eqn;
end
