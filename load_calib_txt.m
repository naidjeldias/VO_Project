
function [cam0, cam1, cam2, cam3] = load_calib_txt()
    %file_path = '/media/nigel/Dados/Documents/Projetos/KITTI DATASET/dataset/sequences/00/calib.txt';
    file_path = 'calib.txt';
    %carregando matrizes das câmeras
    fileId = fopen(file_path,'r');
    %lendo arquivo linha por linha
    tline = fgetl(fileId);
    %separando em vector de caracteres
    tline_vec = strsplit(tline,' ');
    %convertendo os valores para double a partir do segundo elemento
    mat = str2double(tline_vec(2:size(tline_vec,2)));
    %convertendo vector em uma matriz 3x4 
    mat = reshape(mat.', [4 3]).';
    %guardando vetor numa matriz multidimensional
    cam_mats = mat;
    %realizando a mesma operação para as outras linhas do arquivo
    i = 2;
    while ischar(tline)
        %disp(tline)
        tline = fgetl(fileId);
        if(ischar(tline))
            tline_vec = strsplit(tline,' ');
            mat = str2double(tline_vec(2:size(tline_vec,2)));
            mat = reshape(mat.', [4 3]).';
            cam_mats(:,:,i) = mat;
        
            i = i + 1;
        end
       
    end
    fclose(fileId);
    %cada matriz de calibração corresponde a um elemento da matriz
    %unideimenssional
    cam0 = cam_mats(:,:,1);
    cam1 = cam_mats(:,:,2);
    cam2 = cam_mats(:,:,3);
    cam3 = cam_mats(:,:,4);

end
