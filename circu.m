function c=circu(u,v,x,y)
    
    c = trapz(x,u) + trapz(y,v);

end
