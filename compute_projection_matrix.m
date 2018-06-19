
function [P_mat] = compute_projection_matrix(P,p)

    %variaveis de teste
    n = 700;
    X = ones(1,4);
    X(1:3) = P(n,:);
    x = p(n,:);
    
    %defenindo número de pontos
    nr_points = size(P,1);
    %construindo o sistema linear homogêneo
    for i=1:nr_points
        A(2*i-1,:) = [P(i,1), P(i,2), P(i,3), 1, 0, 0, 0, 0, -P(i,1)*p(i,1), -P(i,2)*p(i,1), -P(i,3)*p(i,1) -p(i,1)];
        A(2*i,:)   = [0, 0, 0, 0, P(i,1), P(i,2), P(i,3), 1, -P(i,1)*p(i,2), -P(i,2)*p(i,2), -P(i,3)*p(i,2) -p(i,2)];
    end
    %resolvendo o sistema usando decomposição singular linear
    [U,S,V] = svd(A);
    %A solução que minimiza A é o
    %autovetor associado ao menor autovalor
    index = 1;
    smallValue = 999;
    for i=1:size(S,2)
        if( S(i,i) < smallValue && S(i,i) ~= 0)
            smallValue = S(i,i);
            index = i;
        end
    end
    %A matriz P é definida pelo autovetor associado ao menor autovalor
    P = V(:,index);
    
    %transformando numa matriz 3x4
    %P_mat = reshape(P,[3,4]);
    P_mat = reshape(P,[4,3]);
    P_mat = P_mat';
    
    %reprojetando ponto usando a matriz de projeção
    x_l = P_mat*X';
        
end
    
