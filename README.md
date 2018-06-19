# Descrição

A Odometria Visual é uma área da visão computacional que  tem como principal objectivo estimar a posição de orientação de um agente usando informações provenientes de uma câmera, tendo muitas aplicações nas áreas de robótica móvel, carros autônomos e reconstrução 3D.

Neste projecto é proposto um algoritmo para estimar o movimento de uma câmera estéreo a partir da estimação da pose em dois frames consecutivos.

# Dataset
Para realização dos testes foram utilizados imagens do Kitti, dois pares, esquerda e direita, de frames consecutivos e um documento txt contendo as matrizes de projeção das câmeras correspondentes a cada par de imagens.

# Detecção e extração de features
No projeto foi utilizado o detector e descritor de características A-Kaze, proposto recente por F. Alcantarilla. A técnica apresentada apresenta melhor trade-off entre acurácia na estimação de movimento e eficiência computacional em relação aos demais descritores e detectores com SURF, SIFT e ORB.

# Triangulação estéreo
A informação de profundidade é obtida a partir de triangulação estéreo.

# Estimação de movimento 3D-to-2D
O movimento é estimado a partir de correspondências 3D para 2D, que consiste em encontrar a matriz de transformação que minimiza o erro de projeção de um ponto 3D para imagem. 
