function[Psi]=Laplacien(which,num,dom,cl)

n=max(max(num));
m=length(num);

A = sparse(n,m);
b = sparse(n,1);



for i=1:size(dom,1)
    for k=1:size(dom,2)
        if dom(i,k)~=0
            num_cent=num(i,k);
            [j,a,b2] = getCoeff(num(i,k-1),num(i,k+1),num(i+1,k),num(i-1,k),num_cent,dom(i,k),cl(i,k));
            if num_cent~=0
                b(num_cent)=b2;
                for l=1:length(j)
                    A(num_cent,j(l))=a(l);
                end
            end
        end
    end
end

Psi = A\b;

psi = zeros(size(dom,1),size(dom,2));
for i = 1:max(max(num))
    location = find(num==i);
    x=location;
    psi(x) = Psi(i,1);
end
end