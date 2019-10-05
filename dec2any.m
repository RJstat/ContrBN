function v = dec2any(a,k,len)

% DEC2ANY    Convert a decimal number to a k-based number as a vector of a given length
%            it will add zeros if len is larger than the valid length of the vector
%
%   V = DEC2ANY(A)       % convert a decimal number to a binary number as a vector
%   V = DEC2ANY(A,K)     % convert a decimal number to a K-based number
%   V = DEC2ANY(A,K,LEN) % convert a decimal number to a K-based number of length LEN
%
%   Example: v = dec2any(11)
%            v = dec2any(11,2)
%            v = dec2any(11,2,6)

% $Id: dec2any.m 24 2013-01-24 10:48:00Z hsqi $

if nargin == 1
    k = 2;
    len = 0;
elseif nargin == 2
    len = 0;
end

if a < 0 
    error('The first input argument must be a non-negative integer')
end

if k < 2
    error('The second input argumant must be a positive integer')
end

if len < 0
    error('The third input argumant must be a positive integer')
end

l = ceil(log2(a+0.5)/log2(k));
v = zeros(1,l);

if a < k
    v = [a];
else
    i = 0;
    while (a >= k)
        t = mod(a,k);
        a = floor(a/k);
        v(l-i) = t;
        i = i+1;
    end
    v(1) = a;
end

if len>0 && l<len
    v1 = zeros(1,len);
    v1((len-l+1):len) = v;
    v = v1;
end
