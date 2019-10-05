function m = stp(a)
% STP/STP    Semi-tensor product (STP) class constructor.
%  m = stp(a)    creates an STP object from the matrix A.

% $Id: stp.m 14 2013-01-14 14:45:44Z hsqi $

superiorto('double','sym');

if nargin == 0
    m.c = [];
elseif isa(a,'stp')
    m = a;
    return
elseif isa(a,'double') || isa(a,'sym')
    m.c = a;
elseif isa(a,'lm') || isa(a,'bm')
    m.c = double(a);
else
    error(['Conversion to ''stp'' from ''' class(a) ''' is not allowed.']);
end

m = class(m,'stp');