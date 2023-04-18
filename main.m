tic
cas = ;
switch cas
    case 1
        dom = dlmread('1-dom.txt','\t');
        num = dlmread('1-num.txt','\t');
        cl = dlmread('1-cl.txt','\t');
    case 2
        dom = dlmread('2-dom.txt','\t');
        num = dlmread('2-num.txt','\t');
        cl = dlmread('2-cl.txt','\t');
    case 3
        dom = dlmread('3-dom.txt','\t');
        num = dlmread('3-num.txt','\t');
        cl = dlmread('3-cl.txt','\t');
    case 4
        dom = dlmread('4-dom.txt','\t');
        num = dlmread('4-num.txt','\t');
        cl = dlmread('4-cl.txt','\t');
end

n = max(max(num));

A = zeros(n,n);
b = zeros(n,1);

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
% Resolution du systeme d'equations A*Psi = B.
Psi = sparse(A)\sparse(b);
display(Psi);
    
Mat_Psi = nan(size(dom,1),size(dom,2));
for i = 1:n
    location = find(num==i);
    Mat_Psi(location) = Psi(i,1);
end
display(Mat_Psi);

dx = 0.01;

[nbx , nby] = size (num);
[X,Y] = meshgrid ((0:dx:(nbx-1)*dx) , (0:dx:(nby-1)*dx));
pcolor(X,Y,Mat_Psi');

u = NaN(n,1);
v = NaN(n,1);


for i = 1 : size (dom,1)
    for k = 1 : size (dom,2)
        if dom(i,k) ~= 0
            %vitesse horizontale
            u (num(i,k)) = deriv(Mat_Psi(i-1,k), Mat_Psi(i,k), Mat_Psi(i+1,k), dom(i-1,k), dom(i,k), dom(i+1,k), dx);
        
            %vitesse verticale
            v (num(i,k)) = - deriv(Mat_Psi(i-1,k), Mat_Psi(i,k), Mat_Psi(i+1,k), dom(i-1,k), dom(i,k), dom(i+1,k), dx);
        end 
    end
end


