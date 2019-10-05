function o = lmget(options,key,default)

% LMGET    Get LM OPTIONS parameters

% This file is modified from odeget.m

% $Id: lmget.m 23 2013-01-19 08:29:19Z hsqi $

if nargin < 2
  error('Not enough input arguments.');
end
if nargin < 3
  default = [];
end

if ~isempty(options) & ~isa(options,'struct')
  error('First argument must be an options structure created with LMSET.');
end

if isempty(options)
  o = default;
  return;
end

Keys = [
         'EyeFunc        '
         'KronFunc       '
         'StpFunc        '
         'SwapMatrixFunc '
         'ToLatex        '
         'VarSort        '
         'Vars           '
                         ];
[m,n] = size(Keys);
keys = lower(Keys);

lowKey = lower(key);
j = strmatch(lowKey,keys);
if isempty(j)               % if no matches
  error(sprintf(['Unrecognized property name ''%s''.  ' ...
                 'See LMSET for possibilities.'], key));
elseif length(j) > 1            % if more than one match
  % Check for any exact matches (in case any keys are subsets of others)
  k = strmatch(lowKey,keys,'exact');
  if length(k) == 1
    j = k;
  else
    msg = sprintf('Ambiguous property name ''%s'' ', key);
    msg = [msg '(' deblank(Keys(j(1),:))];
    for k = j(2:length(j))'
      msg = [msg ', ' deblank(Keys(k,:))];
    end
    msg = sprintf('%s).', msg);
    error(msg);
  end
end

if any(strcmp(fieldnames(options),deblank(Keys(j,:))))
  eval(['o = options.' Keys(j,:) ';']);
  if isempty(o)
    o = default;
  end
else
  o = default;
end
