function m = lm(varargin)
% LM/LM    Logical matrix (LM) class constructor
%
%  M = LM(A)  creates an LM object from the matrix A.
%  Example: m = lm(eye(3))
%
%  M = LM(V,N)  creates an LM object from a vector V and a postive integer N
%  Example: m = lm([1,2,2,3],4)

% $Id: lm.m 18 2013-01-14 18:47:25Z hsqi $

ni = nargin;
if ni && isa(varargin{1},'lm'),
    if ni == 1,
        m = varargin{1};
    else
        error('Use SET to modify the properties of LM objects.');
    end
    return;
end

superiorto('double');
m = struct('v',[],'n',0);
inferiorto('stp');

switch ni
case 0
    m = class(m,'lm');
    return;

case 1
    a = varargin{1};
    if isa(a,'stp')
        a = double(a);
    elseif ~isa(a,'double')
        error(['Conversion to ''lm'' from ''' class(a) ''' is not possible.'])
    end
    
    if all(a==1 | a==0) & all(sum(a)),
        [p,q] = size(a);
        k = mod((find(a==1))',p);
        m.v = k + (k==0)*p;
        m.n = p;
    else
        error('The input argument must be a logical matrix.')
    end;
    
otherwise
    if ni >= 3
        warning('Accept two input arguments only, the rest will be skipped.')
    end
    a = varargin{1};
    [p,q] = size(a);
    if ~all(a>0) || (p > 1 && q > 1)
        error('The first input argument must be a vector with positive integers.')
    end
    if p > 1
        a = a';
    end
    m.v = a;

    b = varargin{2};
    if all(size(b)==1) && max(a) <= b
        m.n = b;
    else
        error('The second input argument must be an integer and can not be less than the maximum of the first input argument.')
    end
end

m = class(m,'lm');