function [R,Q] = rq3(A)
    
    if ~all(size(A)==[3 3])
        error('A must be 3x3');
    end
    
    % Find rotation Qx to set A(3,2) to 0
    c = -A(3,3)/sqrt(A(3,3)^2+A(3,2)^2);
    s =  A(3,2)/sqrt(A(3,3)^2+A(3,2)^2);
    Qx = [1 0 0; 0 c -s; 0 s c];
    R = A*Qx;
    
    % Find rotation Qy to set A(3,1) to 0
    c = R(3,3)/sqrt(R(3,3)^2+R(3,1)^2);
    s = R(3,1)/sqrt(R(3,3)^2+R(3,1)^2);
    Qy = [c 0 s; 0 1 0;-s 0 c];
    R = R*Qy;
    
    % Find rotation Qz to set A(2,1) to 0    
    c = -R(2,2)/sqrt(R(2,2)^2+R(2,1)^2);
    s =  R(2,1)/sqrt(R(2,2)^2+R(2,1)^2);    
    Qz = [c -s 0; s c 0; 0 0 1];
    R = R*Qz;
    
    Q = Qz'*Qy'*Qx';
    
    % Adjust R and Q so that the diagonal elements of R are +ve
    for n = 1:3
        if R(n,n) < 0
            R(:,n) = -R(:,n);
            Q(n,:) = -Q(n,:);
        end
    end