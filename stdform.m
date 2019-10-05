function [lm,vars] = stdform(expr,options,k)
% STDFORM    Convert a logical expression to its standard matrix form
%
%    Theorem: In k-valued logic, any logical expression  L(P1,...,Pn) 
%    with free logical variables P1,...,Pn can be expressed in a
%    canonical form as
%                L(P1,...,Pn) = ML*P1*...*Pn,
%    where ML is a k*k^n logical matrix.
% 
%    This function can compute the matrix ML automatically. 
%
%    Usage: [expr1,vars] = stdform(expr,options,k)
%      expr: a logical expression in string, if it is a cell array, 
%            stdform will convert each element of the cell
%      options: it can be set by lmset function, default is []
%      k: the dimension of the logic, default is 2
%      expr1: the first returned value, it is a string which actually is 
%             the algebraic expression of ML
%      vars: the second returned value, it will store all the logical
%            variables in a cell array
%
%    Example: 
%         k=2;MC=lmc(k);MD=lmd(k);MI=lmi(k);MR=lmr(k);
%         [expr1, vars] = stdform('MI MC X Y MD X Z')
%         % Because expr1 is a string, we should get an lm object by the following line
%         expr2 = eval(expr1) 
%      will display
%         expr1 = 'MI*MC*(leye(2)+(leye(2)+MD))*(leye(2)+lwij(2))*MR'
%         vars = {'X', 'Y', 'Z'}
%         expr2 = {v: [ 1  1  1  1  1  1  1  1 ]
%                  n: 2}
%
%    Remark: In this toolbox, a string initialized with a capital M is
%    defined as a logical matrix, otherwise, it is considered as a logical
%    variable. In addition, 'MN', 'MC', 'MD', 'MI', 'ME', and 'MR' are reserved 
%    keywords/variables of structure matrices for negation, conjunction, disjunction, 
%    implication, equivalance, and power-reduing matrix respectively, 
%    so we should define them at first.

% $Id: stdform.m 23 2013-01-19 08:29:19Z hsqi $

if nargin < 1
	error('Not enough input arguments.');
elseif nargin == 1
	options = [];
	k = 2;
elseif nargin == 2
	k = 2;
end;
if iscell(expr),
    lm = cell(size(expr));
	vars = cell(size(expr));
    for i = numel(expr):-1:1
        [lm{i},vars{i}] = stdform(expr{i}, options, k);
    end
    return
end
if ~isa(expr,'char')
	error('The input argument must be a string!');
end;

opn = [];
opn.ToLatex = lmget(options,'ToLatex',0);
opn.Vars = lmget(options,'Vars',{});
opn.VarSort = lmget(options,'VarSort',1);
if opn.ToLatex
	opn.EyeStr = lmget(options,'EyeFunc','I_{%s}');
	opn.KPStr = lmget(options,'KronFunc','(%s\\otimes %s)');
	opn.SPStr = lmget(options,'StpFunc','%s\\ltimes %s');
	opn.SMStr = lmget(options,'SwapMatrixFunc','W_{[%d]}');
	opn.eye = sprintf(opn.EyeStr,num2str(k));
else
	opn.EyeStr = lmget(options,'EyeFunc','leye(%s)');
	opn.KPStr = lmget(options,'KronFunc','(%s+%s)');
	opn.SPStr = lmget(options,'StpFunc','%s*%s');
	opn.SMStr = lmget(options,'SwapMatrixFunc','lwij(%d)');
	opn.eye = sprintf(opn.EyeStr,num2str(k));
end

% get all the logical matrices and variables from the matrix expression
vars = strsplit(expr);

len = length(vars);

if len == 1	% only a variable
	if ~islmvar(vars{1})
		vars{2} = vars{1};
		vars{1} = opn.eye;
	end
	return
end

% ******************************************************************
% assign the logical matrices and variables with different levels,
% the level of logical matrices is 0, the level of the first varibale 
% appeared in opn.Vars is 1, the second one is 2, ...
f = zeros(1,len);
for i = 1:len
	f(i) = ~islmvar(vars{i});
end

if isempty(opn.Vars)
    var = vars(f==1);
    if opn.VarSort
        opn.Vars = unique(var); % variables are sorted by ASCII dictionary order
                                % the function 'unique' includes sorting
    else
        var_by_appeared = {};
        ii = 0;
        for i = var
            marked = 0;
            for j = var_by_appeared
                if strcmp(i,j)
                    marked = 1;
                end
            end
            if ~marked
                ii = ii + 1;
                var_by_appeared(ii) = i;
            end
        end
        opn.Vars = var_by_appeared; % varibles are sorted by their appeared order in the expression
    end
end
varstr = strvcat(opn.Vars);

for i = find(f)
	f(i) = strmatch(vars{i},varstr,'exact');
end

% ******************************************************************
% begin procedure
[vars,f] = PR_Swap(vars,f,opn);
[vars,f] = moveVarBack(vars,f,opn);
[vars,f] = swapVarsByOrder(vars,f,opn,k);
[vars,f] = PR_Swap(vars,f,opn);
[vars,f] = moveVarBack(vars,f,opn);
% vars{1} = convertSP(vars(1:length(f)-max(f)),opn); % this is the matrix ML
lm = convertSP(vars(1:length(f)-max(f)),opn); % this is the matrix ML
% vars(2:length(f)-max(f)) = [];
vars(1:length(f)-length(find(f>0))) = [];
% f(1:length(f)-max(f)) = [];
% end procedure

% *************************************************************************
% permute all the variables (which should have been moved to the end of the 
% expression) in the order of their levels
function [vars1,f1] = swapVarsByOrder(vars,f,opn,k)
v = find(f==0);
vars1 = vars(v); f1 = f(v); vars(v) = []; f(v) = [];
len = 0; m = {}; n = 0;
for s = 1:max(f)
	t = find(f==s);
	l = length(t);
	for i = 1:l
		for j = t(i)-1:-1:len+i
			n = n+1;
			if j == 1
				m{n} = sprintf(opn.SMStr,k);
			elseif j == 2
				m{n} = sprintf(opn.KPStr,opn.eye,sprintf(opn.SMStr,k));
			else
				m{n} = sprintf(opn.KPStr,sprintf(opn.EyeStr,[num2str(k) '^' num2str(j-1)]),sprintf(opn.SMStr,k));
			end
			temp1 = f(j); f(j) = f(j+1); f(j+1) = temp1;
			temp2 = vars{j}; vars{j} = vars{j+1}; vars{j+1} = temp2;
		end
	end
	len = len + l;
end
k = length(f1);
vars1(k+1:k+n) = m; 
vars1(k+n+1:k+n+len) = vars;
f1 = [f1,zeros(1,n),f];

% ******************************************************************
% if there are matrices behind a variable, move the variable backward
function [vars,f] = moveVarBack(vars,f,opn)
len = length(f);
v = find(f);
l = length(v);
for i = l:-1:1
	if v(i) == len
		continue;
	end
	if any(find(f(v(i)+1:len-(l-i))==0))
		vars(v(i):v(i)+1) = swapvm(vars(v(i):len-(l-i)),opn);
		f(v(i)+1) = f(v(i));
		f(v(i)) = 0;
		k = v(i)+2:len-(l-i);
		f(k) = [];
		vars(k) = [];
		len = length(f);
	end
end

% ******************************************************************
% if two same variables are conjoint, power-reduce them by "MR" directly;
% if they are separated by some logical matrices (no variables), swap the
% first variable and these matrices, then it becomes the above case.
function [vars,f] = PR_Swap(vars,f,opn)
for i = 1:max(f)
	v = find(f==i);
	j = 2;
	while j <= length(v)
		if v(j)-v(j-1) == 1
			vars{v(j-1)} = 'MR';
			f(v(j-1)) = 0;
			v = find(f==i);
			continue;
		elseif ~any(f(v(j-1)+1:v(j)-1))
			vars{v(j-1)} = convertKP(convertSP(vars(v(j-1)+1:v(j)-1),opn),opn);
			f(v(j-1):v(j-1)+1) = 0;
			vars{v(j-1)+1} = 'MR';
			k = v(j-1)+2:v(j)-1;
			vars(k) = [];
			f(k) = [];
			v = find(f==i);
			continue;
		end
		j = j+1;
	end
end

% ******************************************************************
% swap a column vector and matrices
function result = swapvm(vars,opn) 
result(1:2) = {convertKP(convertSP(vars(2:end),opn),opn),vars{1}};

% ******************************************************************
% Convert Semi-tensor product
function str = convertSP(vars,opn)
l = length(vars);
if l == 0
	error('The input argument cannot be empty.');
elseif l == 1
	str = vars{l};
else
	str = '';
	for i = 1:l-1
		str = [str,sprintf(opn.SPStr,vars{i},'')];
	end
	str = [str,vars{l}];
end

% ******************************************************************
% Convert Kronecher product
function result = convertKP(var,opn)
result = sprintf(opn.KPStr,opn.eye,var);
