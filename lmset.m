function options = lmset(varargin)
% LMSET    Create/Alter LM OPTIONS structure
%
%    Examples: 
%      options = lmset('Vars',{'X','Y','Z'})
%      options = lmset('Vars',{'x1','x2','x3'},'VarSort',1)

% This file is modified from odeset.m

% $Id: lmset.m 23 2013-01-19 08:29:19Z hsqi $

if (nargin == 0) & (nargout == 0)
  fprintf('         EyeFunc: [ string ], default is ''leye(%%s)''\n');
  fprintf('        KronFunc: [ string ], default is ''(%%s+%%s)''\n');
  fprintf('         StpFunc: [ string ], default is ''(%%s*%%s)''\n');
  fprintf('  SwapMatrixFunc: [ string ], default is ''lwij(%%d)''\n');
  fprintf('         ToLatex: [ 1 | 0 ]\n');
  fprintf('         VarSort: [ 1 | 0 ]\n');
  fprintf('            Vars: [ cell ]\n');
  fprintf('\n');
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

options = [];

for j = 1:m
  eval(['options.' Keys(j,:) '= [];']);
end
i = 1;
while i <= nargin
  arg = varargin{i};
  if isstr(arg)                         % arg is an option name
    break;
  end
  if ~isempty(arg)                      % [] is a valid options argument
    if ~isa(arg,'struct')
      error(sprintf(['Expected argument %d to be a string property name ' ...
                     'or an options structure\ncreated with LMSET.'], i));
    end
    for j = 1:m
      if any(strcmp(fieldnames(arg),deblank(Keys(j,:))))
        eval(['val = arg.' Keys(j,:) ';']);
      else
        val = [];
      end
      if ~isempty(val)
        eval(['options.' Keys(j,:) '= val;']);
      end
    end
  end
  i = i + 1;
end

% A finite state machine to parse name-value pairs.
if rem(nargin-i+1,2) ~= 0
  error('Arguments must occur in name-value pairs.');
end
expectval = 0;                          % start expecting a name, not a value
while i <= nargin
  arg = varargin{i};
    
  if ~expectval
    if ~isstr(arg)
      error(sprintf('Expected argument %d to be a string property name.', i));
    end
    
    lowArg = lower(arg);
    j = strmatch(lowArg,keys);
    if isempty(j)                       % if no matches
      error(sprintf('Unrecognized property name ''%s''.', arg));
    elseif length(j) > 1                % if more than one match
      % Check for any exact matches (in case any keys are subsets of others)
      k = strmatch(lowArg,keys,'exact');
      if length(k) == 1
        j = k;
      else
        msg = sprintf('Ambiguous property name ''%s'' ', arg);
        msg = [msg '(' deblank(Keys(j(1),:))];
        for k = j(2:length(j))'
          msg = [msg ', ' deblank(Keys(k,:))];
        end
        msg = sprintf('%s).', msg);
        error(msg);
      end
    end
    expectval = 1;                      % we expect a value next
    
  else
    eval(['options.' Keys(j,:) '= arg;']);
    expectval = 0;
      
  end
  i = i + 1;
end

if expectval
  error(sprintf('Expected value for property ''%s''.', arg));
end
