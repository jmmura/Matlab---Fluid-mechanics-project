function psi = Q1(dom,num,cl)
n=max(max(num));
A=zeros(n,n);
b=zeros(n,1);
for i=1:size(dom,1)
    for k=1:size(dom,2)
        if dom(i,k)~=0
            num_cent=num(i,k);
            [j,a,b2]=getCoeff(num(i,k-1),num(i,k+1),num(i+1,k),num(i-1,k),num_cent,dom(i,k),cl(i,k));
            if num_cent~=0
                b(num_cent)=b2;
                for l=1:length(j)
                    A(num_cent,j(l))=a(l);
                end
            end
        end
    end
end
psi=sparse(A)\sparse(b);

                

               