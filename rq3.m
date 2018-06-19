function [R,Q] = rq3(A)
    
    if ~all(size(A)==[3 3])
        error('A precisa ser 3x3');
    end
    
    %definindo Qx fazendo A(3,2) a zero
    c = -A(3,3)/sqrt(A(3,3)^2+A(3,2)^2);
    s =  A(3,2)/sqrt(A(3,3)^2+A(3,2)^2);
    Qx = [1 0 0; 0 c -s; 0 s c];
    R = A*Qx;
    
    %definindo Qy fazendo A(3,1) a zero
    c = R(3,3)/sqrt(R(3,3)^2+R(3,1)^2);
    s = R(3,1)/sqrt(R(3,3)^2+R(3,1)^2);
    Qy = [c 0 s; 0 1 0;-s 0 c];
    R = R*Qy;
    
    %definindo Qz fazendo A(2,1) a zero
    c = -R(2,2)/sqrt(R(2,2)^2+R(2,1)^2);
    s =  R(2,1)/sqrt(R(2,2)^2+R(2,1)^2);    
    Qz = [c -s 0; s c 0; 0 0 1];
    R = R*Qz;
    
    Q = Qz'*Qy'*Qx';
    
    %Ajustando R e Q para que a diagonal de R seja positivo
    for n = 1:3
        if R(n,n) < 0
            R(:,n) = -R(:,n);
            Q(n,:) = -Q(n,:);
        end
    end