function [psi,u,v] = submit(which)

switch which
    case 1
        dom = dlmread('1-dom.txt','\t');
        num = dlmread('1-num.txt','\t');
        cl = dlmread('1-cl.txt','\t');
        dx = 0.5;
    case 2
        dom = dlmread('2-dom.txt','\t');        
        num = dlmread('2-num.txt','\t');
        cl = dlmread('2-cl.txt','\t');
        dx = 0.001;
    case 3
        dom = dlmread('3-dom.txt','\t');        
        num = dlmread('3-num.txt','\t');
        cl = dlmread('3-cl.txt','\t');
        dx = 0.01;
    case 4
        dom = dlmread('4-dom.txt','\t');
        cl = dlmread('4-cl.txt','\t');
        num = dlmread('4-num.txt','\t');
        dx = 0.01;
end

compteur1=0;
compteur2=1;
[p,q] = size(dom);
dim = (p-2)*(q-2); 
A = sparse(dim, dim);
b = sparse(dim,1);
for i=1:size(dom,1)
    for k=1:size(dom,2)
        if(dom(i,k)~=0)
            [j,a,b2] = getCoeff(num(i,k-1), num(i,k+1), num(i+1,k), num(i-1,k), num(i,k), dom(i,k), cl(i,k));
                           
          
            for q = 1 : length(j)
      
                index_ia(compteur1+q) = num(i,k);
                index_ja(compteur1+q) = j(q);
                val_a(compteur1+q) = a(q);
    
            end   
  
            compteur1 = compteur1+q;

            index_ib(compteur2) = num(i,k);
            index_jb(compteur2) = 1;
            val_b(compteur2)=b2;
            compteur2=compteur2+1;
            
        end
    end
end

A = sparse(index_ia,index_ja,val_a);
b = sparse(index_ib,index_jb,val_b);

Psi = A\b;

psi = NaN(size(num,1),size(num,2));
for i=1:size(num,1)
    for k=1:size(num,2) 
        if(num(i,k)~=0)
            psi(i,k) = Psi(num(i,k)); 
        end
    end
end

u = NaN(size(dom,1),size(dom,2));
v = NaN(size(dom,1),size(dom,2));
for i=1:size(dom,1)
    for k=1:size(dom,2)
        if(dom(i,k)~=0)
            v(i,k) = deriv(psi(i+1,k), psi(i,k),psi(i-1,k), dom(i+1,k), dom(i,k), dom(i-1,k), dx);
            u(i,k) = deriv(psi(i,k-1),psi(i,k),psi(i,k+1), dom(i,k-1), dom(i,k), dom(i,k+1), dx);
        end
    end
end




end

function [j, a, b] = getCoeff(num_left, num_right, num_down, num_up, num_cent, type_cent, cl_cent)

if type_cent == 0
end
if type_cent == 1 
    j = [num_left;num_right;num_down;num_up;num_cent];
    a = [1;1;1;1;-4];
    b = cl_cent;
elseif type_cent==2
    j = num_cent;    
    a = 1;
    b = cl_cent;
end
    
end


function v = deriv(f_left, f_c, f_right, type_left, type_c, type_right, h)
    
    if type_c == 0
        v = 0;
    end
    if type_c == 2 && type_right == 0
        v = (f_c-f_left)/h;
    end
    if type_c == 2 && type_left ~= 0 && type_right ~=0
        v = (f_right-f_left)/(2*h);
    end
    if type_c == 2 && type_left == 0
        v = (f_right-f_c)/h;
    end
    if type_c == 1 
        v = (f_right-f_left)/(2*h);
    end
end






            
            