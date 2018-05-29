clear all;
clc;

%carregando matrizes de projeção
[cam0, cam1, cam2, cam3] = load_calib_txt();

%baseline em relação a distancia focal
B = -cam1(1,4);
%baseline em metros
B_m = B/cam1(1,1);

%computando matrizes intrisecas das câmeras
intrisic_cam0 = eye(3);
intrisic_cam1 = eye(3);
%convertendo para coordenadas homogêneas
intrisic_cam0_h(1:3,1:3) = cam2(1:3,1:3);
intrisic_cam1_h(1:3,1:3) = cam3(1:3,1:3);

%carregando imagens
im_left = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_0/000000.png');
im_right = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_1/000000.png');
im_left2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_0/000001.png');
im_right2 = imread('/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/image_1/000001.png');

%convertendo para grayscale
if(size(im_left,3)>=3 && size(im_right,3)>=3)
    im_left_gray = rgb2gray(im_left);
    im_left2_gray = rgb2gray(im_left2);
    
    
else
    im_left_gray = im_left;
    im_left2_gray = im_left2;
    
    im_right_gray = im_right;
    im_right2_gray = im_right2;
end

%fazendo a correspondencia entre os pontos da imagem da direita e da
%esquerda
[matchedPointsA,matchedPointsB] = matching_points_2_frames(im_left_gray,im_right);

poinst3D = compute_3D_points(matchedPointsA.Location, matchedPointsB.Location, B);
%apresentando as duas imagens e as features correlacionadas
%figure; showMatchedFeatures(im_left_gray, im_right_gray, matchedPointsA, matchedPointsB);
%legend('Imagem 1', 'Imagem2');





