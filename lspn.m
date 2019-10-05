function r = lspn(varargin)

% LSPN    (Left) Semi-tensor product for arbitrary number of logical matrices,
%         return an LM object
%
%   LSPN(A,B,C,...) calculates the (left) semi-tensor product of more 
%   than two logical matrices which have the proper dimensions.

% $Id: lspn.m 14 2013-01-14 14:45:44Z hsqi $

ni = nargin;
switch ni
    case 0
        error('No input arguments')
    case 1
        r = lm(varargin{1});
        return
    case 2
        r = lsp(varargin{1},varargin{2});
        return
    otherwise
        r = lsp(varargin{1},varargin{2});
        for i = 3:ni
            r = lsp(r,varargin{i});
        end
end