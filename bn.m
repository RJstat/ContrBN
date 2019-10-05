function [n,l,c,r0,T] = bn(L,k)

% BN    Analyze dynamics of a Boolean network from its network transition matrix
%
%   [n,l,c,r0,T] = BN(L) return the number of attractors (n), lengths of cycles (l), 
%                        cycle elements (c), and transient time ([r0,t]) 
%                        of the Boolean network with L
%
%   Examples: see example_bn(01-06).m

% $Id: bn.m 25 2013-01-31 18:48:28Z hsqi $

if nargin == 1
	k = 2;
end

FINDC = 1;		% Find the cycles
FINDT = 1;		% Find the transient time
DISPALL = 0;	% Display the lengths, cycles, and transient time
if nargout == 0
	DISPALL = 1;
elseif nargout <= 3
	FINDT = 0;
end

N = floor(log2(length(L)+0.5)/log2(k));	% number of nodes
r = k^N;

if FINDC
	nl = 0;		% number of different lengths of attractors
	pw = [];	% possible length of cycles
	eq = {};	% all cycle elements
	H = leye(r);
	tr0 = 0;
	for i = 1:r
		H = H*L;
		tr1 = trace(H);
		if tr1 > tr0
			nl = nl + 1;
			pw(nl) = i;
			eq{nl} = H( find( diag(H) == 1 ) );
			tr0 = tr1;
		end;
	end;
	for i = nl:-1:2
		for j = i-1:-1:1
			if mod(pw(i),pw(j)) == 0
				eq{i}.v = setdiff(eq{i}.v,eq{j}.v);
			end
		end
	end

	c = {};		% all cycles
	n = 0;		% cycle index
	l = [];		% all lengths of attractors
	for i=1:nl
		while (~isempty(eq{i}))
			n = n + 1;
			x0 = eq{i}(1); % initial state
			ss = x0.v;
			sc = [];
			sc(1,:) = v2s(x0,k);
			for j = 1:pw(i)
				x1 = L * x0;
				sc(j+1,:) = v2s(x1,k);
				x0 = x1;
				ss = [ss x0.v];
			end
			eq{i}.v = setdiff(eq{i}.v,ss);
			c{n} = sc;
			l(1,n) = pw(i);
		end
	end
end

if FINDT
	LL = {L};
	for i = 2:r
		LL{i} = LL{i-1}*L;
	end
	rr = r^2;
	r0 = 0; T = 0;
	found = 0;
	for i = 1 : rr-1
		H = LL{1};
		LL(1) = [];
		% if i < rr - r + 1
			LL{r} = LL{r-1}*L;
		% end
		for j = 1:length(LL)
			if H == LL{j}
				r0 = i;
				T = j;
				found = 1;
				break;
			end
		end
		if found == 1
			break;
		end
	end
end

if DISPALL
fprintf('Number of attractors: %d\n\n',n);
fprintf('Lengths of attractors:\n');
disp(l);
fprintf('\nAll attractors are displayed as follows:\n\n');
for i=1:length(c)
	fprintf('No. %d (length %d)\n\n',i,l(i));
	disp(c{i});
end
fprintf('Transient time: [r0, T] = [%d %d]\n\n',r0,T);
return
end
