function [fx,fy]=force(p,x,y)
    fx = trapz(x,p);
    fy = trapz(y,p);
    endp