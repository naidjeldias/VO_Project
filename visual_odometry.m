clear all;
clc;

%carregando matrizes das câmeras
fileId = fopen('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/calib.txt','r');
formatSpec = '%d %f';
calibInfo_size = [4 13];
calibInfo = fscanf(fileId,formatSpec,calibInfo_size);
fclose(fileId);


%carregando imagens
im_left = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_2/000000.png');
im_right = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_3/000000.png');
im_left2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_2/000001.png');
im_right2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_3/000001.png');

%convertendo para grayscale
im_left_gray = rgb2gray(im_left);
im_left2_gray = rgb2gray(im_left2);

%detectando as features
blobsA = detectKAZEFeatures(im_left_gray);
blobsB = detectKAZEFeatures(im_left2_gray);

%plotando as features
%{ 
strongest = selectStrongest(blobsA,10);
imshow(im_left);
hold on;
plot(strongest);
hold off;
%}

%extraindo descritores
[featuresA, validPointsA] = extractFeatures(im_left_gray, blobsA);
[featuresB, validPointsB] = extractFeatures(im_left2_gray, blobsB);

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

%apresentando as duas imagens e as features correlacionadas

figure; showMatchedFeatures(im_left_gray, im_left2_gray, matchedPointsA, matchedPointsB);
legend('Imagem 1', 'Imagem2');





