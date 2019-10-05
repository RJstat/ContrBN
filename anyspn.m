function r = anyspn(varargin)

% ANYSPN    (Left) Semi-tensor product of arbitrary matrices with arbitrary number of matrices
% 
%   ANYSPN(A,B,C,...) calculates the (left) semi-tensor product of arbitrary 
%   number of matrices which have arbitrary dimensions.

% $Id: anyspn.m 15 2013-01-14 16:51:38Z hsqi $

ni = nargin;
switch ni
    case 0
        error('No input arguments.')
    case 1
        r = varargin{1};
        return
    case 2
        r = anysp(varargin{1},varargin{2});
        return
    otherwise
        r = anysp(varargin{1},varargin{2});
        for i = 3:ni
            r = anysp(r,varargin{i});
        end
end