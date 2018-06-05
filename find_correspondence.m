function [matchedPoints_t, points3D_t0] = find_correspondence(features_t0,frame_t1, points3D, index_t0)
    
    points3D_t0 = zeros(size(points3D,1),3);
    indexMatched = zeros(size(points3D,1),1);
    
    blobs = detectKAZEFeatures(frame_t1);
    
    [features_t1, validPoints_t1] = extractFeatures(frame_t1, blobs);
    
    indexPairs = matchFeatures(features_t0, features_t1, 'Unique', true, 'MaxRatio', 0.3);
    
    count = 1;
    
    for i=1:size(indexPairs,1)
        j = find(index_t0 == indexPairs(i,1));
        if(~isempty(j))
            points3D_t0(count,:) = points3D(j,:);
            indexMatched(count) = indexPairs(i,2);
            count = count + 1;
        end
    end
    
    matchedPoints_t = validPoints_t1(indexMatched(1:count-1,1));
    points3D_t0 = points3D_t0(1:count-1,:);
end

