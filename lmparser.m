function result = lmparser(expr)

% LMPARSER    Convert a logical expression to its matrix form
%
%   The operators !,&,|,- and = denote negation, conjunction, disjunction, 
%   implication and equivalence respectively in the input logical expression.
%   A variable name must begin with a letter, and the initial character can
%   be followed by any digit or letter. "MN","MC","MD","MI","ME" and "MR"
%   are keywords, and cannot be used as variable names.
%   You can add new operators by enlarging the operator priority table and
%   the operator list.
%   Below are two examples to show the usage of this m-function.
%
%   lmparser('!P&Q|R') will return 
%     MD MC MN P Q R
%
%   lmparser('(A=!B)&(B=!C)&(C=!A&!B)') will return
%     MC MC ME A MN B ME B MN C ME C MC MN A MN B

% $Id: lmparser.m 17 2013-01-14 17:51:23Z hsqi $

if nargin < 1
    error('Not enough input arguments.');
elseif nargin > 1
    error('Too many input arguments.');
elseif ~isa(expr,'char')
    error('The input argument must be a string!');
end;

% operator priority table of in-stack and out-stack operators
OpTable = [0 1 1 1 1 0 1;  
           0 1 1 1 1 0 1;
           0 0 1 1 1 0 1;
           0 0 0 1 1 0 1;
           0 0 0 0 1 0 1;
           0 0 0 0 0 0 2;
           -1 1 1 1 1 -1 1];
ops = '!&|-=()'; % operator list
LM =['MN';'MC';'MD';'MI';'ME';'  ';'  ']; % logical matrices
NOT = 1; AND = 2; OR = 3; IMP = 4; EQU = 5; LPAREN = 6; RPAREN = 7; 
ID = 32; BINOP = 33;
expr = strcat(expr,')'); 
len = length(expr);
opnd = {}; opndtop = 0; % initialize operand stack
oper = {'('}; opertop = 1; % initialize operator stack
BracketCount = 0; LastOp = 0; LastStatus = LPAREN;
i = 1;
while (i <= len) 
    ch = expr(i);
    if isletter(ch)
        if LastStatus == RPAREN | LastStatus == ID
            error('parse error!');
        end
        idstr = ch;
        i = i + 1;
        while i <= len
            ch = expr(i);
            if isletter(ch) | isdigit(ch)
                idstr = [idstr,ch];
            else
                break;
            end
            i = i + 1;
        end
        if isKeyword(idstr,LM)
            error(['"',idstr,'"',' is a keyword, which cannot be used as a variable name!']);
        end
        opndtop = opndtop + 1;
        opnd{opndtop} = idstr;  % push identifier into operand stack
        LastStatus = ID;
    elseif isop(ch,ops)
        CurrentOp = findstr(ch,ops);
        switch CurrentOp
            case NOT  % If current operator is an unary operator
                if LastStatus == RPAREN | LastStatus == ID
                    error('parse error!');
                end
                opertop = opertop + 1;
                oper{opertop} = ch;
                LastStatus = NOT;
            case LPAREN % If current operator is a left bracket 
                if LastStatus == RPAREN | LastStatus == ID
                    error('parse error!');
                end;
                BracketCount = BracketCount + 1;
                opertop = opertop + 1;
                oper{opertop} = ch;
                LastStatus = LPAREN;
            case RPAREN % If current operator is a right bracket
                if ~(LastStatus == ID | LastStatus == RPAREN)
                    error('parse error!');
                end;
                if i < len
                    BracketCount = BracketCount - 1;
                end
                if BracketCount < 0
                    error('")" not match.');
                end;
                LastOp = findstr(oper{opertop},ops);
                while opertop > 0 & LastOp ~= LPAREN
                    if LastOp == NOT
                        opnd{opndtop} = [LM(LastOp,:),' ',opnd{opndtop}];
                    else
                        opnd{opndtop - 1} = [LM(LastOp,:),' ',opnd{opndtop-1},' ',opnd{opndtop}];
                        opnd(opndtop) = [];
                        opndtop = opndtop - 1;
                    end
                    oper(opertop) = [];
                    opertop = opertop - 1;
                    LastOp = findstr(oper{opertop},ops);
                end
                oper(opertop) = [];
                opertop = opertop - 1;
                LastStatus = RPAREN;
            otherwise % If current operator is a binary operator
                if ~(LastStatus == ID | LastStatus == RPAREN)
                    error('parse error!');
                end;
                LastOp = findstr(oper{opertop},ops);
                while opertop > 0 & LastOp ~= LPAREN
                    switch OpTable(LastOp,CurrentOp)
                        case 0
                            break;
                        case 1                        
                            if LastOp == NOT
                                opnd{opndtop} = [LM(LastOp,:),' ',opnd{opndtop}];
                            else
                                opnd{opndtop - 1} = [LM(LastOp,:),' ',opnd{opndtop-1},' ',opnd{opndtop}];
                                opnd(opndtop) = [];
                                opndtop = opndtop - 1; 
                            end
                            oper(opertop) = [];
                            opertop = opertop - 1;
                        % case 2
                        % case -1
                        %     error('parse error!');
                    end
                    LastOp = findstr(oper{opertop},ops);
                end
                opertop = opertop + 1;
                oper{opertop} = ch;
                LastStatus = BINOP;
        end
        i = i + 1;
    elseif ch == ' ' % skip space
        i = i + 1;
    else
        error(['illegal character: ',ch]);
    end
    if i > len & BracketCount > 0
        error('"(" not match.');
    end;
end
if opndtop == 1 & opertop == 0
    result = opnd{opndtop};
else
    error('parse error!');
end

function result = isop(op,ops) % is the character an operator
result = ~isempty(findstr(op,ops));

function result = isdigit(ch) % is the character a digit
result = 0;
if ch >= '0' & ch <= '9'
    result = 1;
end

function result = isKeyword(var,keywords) % is the string a keyword
result = ~isempty(strmatch(var,keywords,'exact'));