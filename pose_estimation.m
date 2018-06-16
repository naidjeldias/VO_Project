function [pose_mat] = pose_estimation(points3D,pointsImage,K)

    H = compute_homography(points3D, pointsImage);
    
    %compute essential matrix using intrisic camera matrix
    %E = K'*H*K;
    %decompondo E usando decomposição svd
    [U,S,V] = svd(H);
    
    %diag_110 = [1 0 0; 0 1 0; 0 0 0];
    %newE = U*diag_110*V';
    
    %[U,S,V] = svd(newE);
    
    vT = V';
    
    W = [0 -1 0;1 0 0;0 0 1];
    
    R1 = U*W*V';

    R2 = U*W'*V';
    
    t1 = U(:,3);
    
    t2 = -U(:,3);

end

