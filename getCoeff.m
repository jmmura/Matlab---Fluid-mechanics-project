function  [j,a,b] = getCoeff(num_left, num_right, num_down, num_up, num_cent, type_cent, cl_cent)
if type_cent==1
    j=[num_left;num_right;num_down;num_up;num_cent];
    a=[1;1;1;1;-4];
    b=0;
end
if type_cent==2
        j=num_cent;
        a=1;
        b=cl_cent;
end
end

    
     
        
    


