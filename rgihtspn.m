function r = rightspn(varargin)

% RIGHTSPN    Right Semi-tensor product of matrices with arbitrary number of matrices
% 
%   RIGHTSPN(A,B,C,...) calculates the right semi-tensor product of arbitrary 
%   number of matrices which have the proper dimensions.

% $Id: rgihtspn.m 15 2013-01-14 16:51:38Z hsqi $

ni = nargin;
switch ni
    case 0
        error('No input arguments.')
    case 1
        r = varargin{1};
        return
    case 2
        r = rightsp(varargin{1},varargin{2});
        return
    otherwise
        r = rightsp(varargin{1},varargin{2});
        for i = 3:ni
            r = rightsp(r,varargin{i});
        end
end