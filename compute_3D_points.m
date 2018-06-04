function [points3D_h] = compute_3D_points(matchedPointsA,matchedPointsB,Bf, fu,fv,cu,cv)
    %convertendo para coordenadas homogêneas
    matchedPointsA_h = ones(size(matchedPointsA,1),3);
    matchedPointsB_h = ones(size(matchedPointsB,1),3);
    
    matchedPointsA_h(:,1:2) = matchedPointsA(:,:);
    matchedPointsB_h(:,1:2) = matchedPointsB(:,:);
    
    d = matchedPointsB_h(:,1)- matchedPointsA_h(:,1);
    
    Z = Bf./(-d);
    
    points3D_h = (matchedPointsA_h(:,1) - cu ).*(Z/fu);
    points3D_h = horzcat(points3D_h, (matchedPointsA_h(:,2) - cv).*(Z/fv));
    points3D_h = horzcat(points3D_h, Z.*matchedPointsA_h(:,3));
    %points3D_h = int32(points3D_h);
    
end

