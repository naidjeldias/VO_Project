function [points3D_h] = compute_3D_points(matchedPointsA,matchedPointsB,baseline)
    %convertendo para coordenadas homogêneas
    matchedPointsA_h = ones(size(matchedPointsA,1),3);
    matchedPointsB_h = ones(size(matchedPointsB,1),3);
    
    matchedPointsA_h(:,1:2) = matchedPointsA(:,:);
    matchedPointsB_h(:,1:2) = matchedPointsB(:,:);
    
    d = matchedPointsB_h(:,1) - matchedPointsA_h(:,1);
    
    points3D_h = -(baseline./d).*matchedPointsA_h(:,1);
    points3D_h = horzcat(points3D_h, -(baseline./d).*matchedPointsA_h(:,2));
    points3D_h = horzcat(points3D_h, -(baseline./d).*matchedPointsA_h(:,3));
    
end

