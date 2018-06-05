clear all;
clc;
close all;

%carregando matrizes de projeção
[P_rect0, P_rect1, P_rect2, P_rect3] = load_calib_txt();

%baseline em relação a distancia focal
Bf = -P_rect1(1,4);
%distancial focal
fu = P_rect0(1,1);
fv = P_rect0(2,2);
%centro da imagem
cu = P_rect0(1,3);
cv = P_rect0(2,3);

%computando matrizes intrisecas das câmeras
intrisic_cam0 = eye(3);
intrisic_cam1 = eye(3);
%convertendo para coordenadas homogêneas
intrisic_cam0_h(1:3,1:3) = P_rect0(1:3,1:3);
intrisic_cam1_h(1:3,1:3) = P_rect1(1:3,1:3);

%carregando imagens
im_left = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_0/000000.png');
im_right = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_1/000000.png');
im_left2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_0/000001.png');
im_right2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_1/000001.png');

%convertendo para grayscale
if(size(im_left,3)>=3 && size(im_right,3)>=3)
    im_left_gray = rgb2gray(im_left);
    im_left2_gray = rgb2gray(im_left2);
    
    im_right_gray = rgb2gray(im_right);
    im_right2_gray = rgb2gray(im_right2);
else
    im_left_gray = im_left;
    im_left2_gray = im_left2;
    
    im_right_gray = im_right;
    im_right2_gray = im_right2;
end

%fazendo a correspondencia entre os pontos da imagem da direita e da
%esquerda
[matchedPointsL,matchedPointsR,features_t0,index_t0] = matching_points_2_frames(im_left_gray,im_right_gray);

%computando os pontos 3D do matching
points3D = compute_3D_points(matchedPointsL.Location, matchedPointsR.Location, Bf, fu,fv,cu,cv);

%{
x = ones(1,4);
x(1:3) = points3D(2,:);
x = x';
x_i = P_rect1*x;
%}

%fazendo a correspondencia entre os pontos da imagem da esquerda no
%instante t-1 com a imagem da esquerda no instante t
[matchedPoints_t1, points3D_t0] = find_correspondence(features_t0,im_left2_gray, points3D, index_t0);

pose = pose_estimation(points3D_t0, matchedPoints_t1.Location);

%apresentando as duas imagens e as features correlacionadas
%figure; showMatchedFeatures(im_left_gray, im_right_gray, matchedPointsA, matchedPointsB);
%legend('Imagem 1', 'Imagem2');





