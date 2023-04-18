function v=deriv(f_left,f_c,f_right,type_left,type_c,type_right,h)

if type_c ~= 0
    if type_left==0
        v =  (f_right-f_c)/h;
    elseif type_right == 0
        v =  (f_c-f_left)/h;
    else
         v =  (f_right-f_left)/(2*h);   
    end
end

end