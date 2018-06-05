function [matchedPointsA,matchedPointsB,featuresA,index_t0] = matching_points_2_frames(imageA,imageB)
    
    %detectando as features
    blobsA = detectKAZEFeatures(imageA);
    blobsB = detectKAZEFeatures(imageB);

    %plotando as features
    %{ 
    strongest = selectStrongest(blobsA,10);
    imshow(im_left);
    hold on;
    plot(strongest);
    hold off;
    %}

    %extraindo descritores
    [featuresA, validPointsA] = extractFeatures(imageA, blobsA);
    [featuresB, validPointsB] = extractFeatures(imageB, blobsB);

    %
    %fazendo correspondência das features das duas imagens
    %Inputs:
    %   - unique: correspondencias unicas entre as imagens
    %   - MaxRatio: 0 < R < 1 limiar para remover ambiguidades
    %
    indexPairs = matchFeatures(featuresA, featuresB, 'Unique', true, 'MaxRatio', 0.3);
    numMatchedPoints = int32(size(indexPairs,1));

    %extraindo os pontos que tiveram correspondencia
    matchedPointsA = validPointsA(indexPairs(:,1));
    matchedPointsB = validPointsB(indexPairs(:,2)); 
    index_t0       = indexPairs(:,1);

end

