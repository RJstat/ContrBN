function P=PhiK(k)
Mr=[1 0 0 0;0 0 0 1]';
P1=sp(kron(eye(2),wij(2,1)),Mr);
if k==1
    P=P1;
else
    P1=sp(kron(eye(2),wij(2,2^(k-1))),Mr);
    for i=2:k
        Ptemp=sp(kron(eye(2),wij(2,2^(k-i))),Mr);
        P0=kron(eye(2^(i-1)),Ptemp);
        P1=sp(P1,P0);
    end
    P=P1;
end

