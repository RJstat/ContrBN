
%addpath('C:\Users\CHAO\Google Drive\JIN\stp');

k = 2;       % Two-valued logic
MC = lmc(k); % structure matrix for conjunction
ME = lme(k); % structure matrix for equivalance
MN = lmn(k); % structure matrix for negation
MR = lmr(k); % power-reducing matrix
MD = lmd(k); % disjunction

% The logical expression  for the third line can be written as
% logic_expr1= '(!D)&(A)';
% logic_expr2= '(!E)&B';
% logic_expr3= '(!B)&(D|C)';
% where | is disjunction, & is conjunction, and ! is negation

% convert the logic expresson to its matrix form

tic
fid=fopen(DataName); % ????
row=0;
while ~feof(fid) % ?????????
    [~]=fgets(fid); % ??fgetl
    row=row+1; % ????
end
fclose(fid); 

fid=fopen(DataName); % ????
logic_expr=cell(row,1); i=1;
while ~feof(fid) % ?????????
    logic_expr{i,1}=fgetl(fid); % ??fgetl
    i=i+1; % ????
end
fclose(fid); 
toc
matrix_expr=cell(row,1);
eqn=cell(1,row);
for i=1:row
matrix_expr{i,1} = lmparser(logic_expr{i,1});
eqn{1,i}=matrix_expr{i,1};
end

[expr0,vars] = stdform(strjoin(eqn));

% Calculate the network transition matrix
L0 = eval(expr0);
v1=L0.v ;
TranMatr=zeros(2^row,2^row);
%sprintf('%s/Transition Matrix.txt',Output)
fid=fopen(sprintf('%s/Transition Matrix.txt',Output),'w');
for k=1:2^row;
    %key='e_{32}^';
   %fprintf(fid,'%s%i->%s%i\n',key,k,key,v1(1,k));
   
   TranMatr(v1(1,k),k)=1;
end
fprintf(fid,'The Transition Matrix is\n');
for i=1:2^row
   for j=1:2^row
       fprintf(fid,'%i\t',TranMatr(i,j));
   end
   fprintf(fid,'\n');
end
save('TranMatr.mat','TranMatr');
load('TranMatr.mat');
l=2^row;
Ids=cell(1,2^row);
ArrowSizeValue=-8;
for k=1:2^row;
Ids{1,k}=sprintf('State e_%i^%i',l,k);
end
bg = biograph(TranMatr',Ids);
view(bg)

fprintf(fid,'The Reachable Integrated Nodes and Their Corresponding States are\n');
% Detection of Controllable or Reachable%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dir=zeros(2^row+1,1);
for i=1:2^row
    for j=1:2^row
    dir(1)=i;
    dir(j+1)=v1(1,dir(j));
    error=v1(1,dir(j+1))-i;
    if error==0
        fprintf(fid,'%i\n',i);
        break;
    end
    if error ~=0
        continue;
    end
    end
end
fclose(fid);
%Making the reference%table%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = table;
IntegratedState=cell(1,2^row);
Nodes=cell(row,2^row);
b=zeros(1,row);
for i=1:2^row
   for j=1:row;
   IntegratedState{1,i}=sprintf('e_%i^%i',l,i); 
    a=dec2bin(2^row-i);
    if length(a)<row
       for k=1:(row-length(a))
        b(k)=0;end
    for k=(row-length(a)+1):row
        b(k)=a(k-row+length(a));end
    end
    if length(a)==row
        b=a;end
    Nodes{j,i}=b(j);
   end
end
T.State=IntegratedState';
T.Node=Nodes';
writetable(T,'The_Corresponding_Node_Table_of_Each_Integrated_State.txt')
type 'The_Corresponding_Node_Table_of_Each_Integrated_State.txt'






