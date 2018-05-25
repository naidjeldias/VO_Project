clear all;
clc;

%carregando matrizes de projeção
[cam0, cam1, cam2, cam3] = load_calib_txt();

%computando matrizes intrisecas das câmeras
intrisic_cam2 = eye(4);
intrisic_cam3 = eye(4);
intrisic_cam2(1:3,1:3) = cam2(1:3,1:3);
intrisic_cam3(1:3,1:3) = cam3(1:3,1:3);

%carregando imagens
im_left = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_2/000000.png');
im_right = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_3/000000.png');
im_left2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_2/000001.png');
im_right2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_3/000001.png');

%convertendo para grayscale
im_left_gray = rgb2gray(im_left);
im_left2_gray = rgb2gray(im_left2);

[matchedPointsA,matchedPointsB] = matching_points_seq_frames(im_left_gray,im_left2_gray);

%apresentando as duas imagens e as features correlacionadas
%figure; showMatchedFeatures(im_left_gray, im_left2_gray, matchedPointsA, matchedPointsB);
%legend('Imagem 1', 'Imagem2');





