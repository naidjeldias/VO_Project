
function [h_mat] = compute_homogra(P,p)

    %variaveis de teste
    n = 700;
    X = ones(1,4);
    X(1:3) = P(n,:);
    x = p(n,:);
    
    %defenindo número de pontos
    nr_points = 900;
    %construindo o sistema linear homogêneo
    for i=1:nr_points
        %Px_h = P(i,1)/P(i,3);
        %Py_h = P(i,2)/P(i,3);
        %A(2*i-1,:) = [Px_h,Py_h,1,0,0,0,-Px_h*p(i,1),-p(i,1)*Py_h,-p(i,1)];
        %A(2*i, :)  = [0,0,0,Px_h,Py_h,1,-Px_h*p(i,2),-p(i,2)*Py_h,-p(i,2)];
        A(2*i-1,:) = [P(i,1), P(i,2), P(i,3), 1, 0, 0, 0, 0, -P(i,1)*p(i,1), -P(i,2)*p(i,1), -P(i,3)*p(i,1) -p(i,1)];
        A(2*i,:)   = [0, 0, 0, 0, P(i,1), P(i,2), P(i,3), 1, -P(i,1)*p(i,2), -P(i,2)*p(i,2), -P(i,3)*p(i,2) -p(i,2)];
    end
    %resolvendo o sistema usando decomposição singular linear
    [U,S,V] = svd(A);
    %A solução que minimiza A é o
    %autovetor associado ao menor auto valor
    index = 1;
    smallValue = 999;
    for i=1:size(S,2)
        if( S(i,i) < smallValue && S(i,i) ~= 0)
            smallValue = S(i,i);
            index = i;
        end
    end
    
    P = V(:,index);
    
    %P = P.*-1;
    
    %transformando numa matriz 3x4
    %P_mat = reshape(P,[3,4]);
    P_mat = reshape(P,[4,3]);
    P_mat = P_mat';
    
    %reprojetando ponto usando a matriz de projeção
    x_l = P_mat*X';
    
    %normalização P_mat
    P_mat = P_mat*sign(det(P_mat(1:3,1:3)));
    
    %[K, Rc_w, Pc, pp, pv] = decomposecamera(P_mat);

    %estimando C
    [U,S,V] = svd(P_mat);
    C = V(1:3,end)/V(end,end);
    

    %decompondo P usando fatorização QR
    [R,K] = qr(P_mat(1:3,1:3));
    
    %garantindo a diagonal positiva de K
    D = diag(sign(diag(K)));
    K = K*D;
    R = D*R;
    K = K/K(end,end);
    
    d = det(R);
    t = -R*C;
    
end
    
