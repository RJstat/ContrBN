function r = spn(varargin)

% SPN    (Left) Semi-tensor product of matrices with arbitrary number of matrices
% 
%   SPN(A,B,C,...) calculates the (left) semi-tensor product of arbitrary 
%   number of matrices which have the proper dimensions.

ni = nargin;
switch ni
    case 0
        error('No input arguments.')
    case 1
        r = varargin{1};
        return
    case 2
        r = sp1(varargin{1},varargin{2});
        return
    otherwise
        r = sp1(varargin{1},varargin{2});
        for i = 3:ni
            r = sp1(r,varargin{i});
        end
end