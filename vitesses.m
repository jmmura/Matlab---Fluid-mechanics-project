function [u,v] = vitesses(dom,psi,dx)

u = NaN(n,1);
v=NaN(n,1);

for i = 1 : size (dom,1)
    for k = 1 : size (dom,2)
        if dom(i,k) ~= 0
            u (num(i,k)) = deriv(psi(i-1,k), psi(i,k), psi(i+1,k), dom(i-1,k), dom(i,k), dom(i+1,k), dx);
            v (num(i,k)) = - deriv(psi(i-1,k), psi(i,k), psi(i+1,k), dom(i-1,k), dom(i,k), dom(i+1,k), dx);
        end 
    end
end