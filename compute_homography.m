function [h_mat] = compute_homogra(P,p)
    
    nr_points = 8;
    
    for i=1:nr_points
        Px_h = P(i,1)/P(i,3);
        Py_h = P(i,2)/P(i,3);
        A(2*i-1,:) = [Px_h,Py_h,1,0,0,0,-Px_h* ];
        A(2*i, :) =[];       
    end
    
end
    
