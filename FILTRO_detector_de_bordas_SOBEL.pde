PImage img;
PImage bordasSobel;

void setup() {
  size(640, 480);
  img = loadImage("Bikesgray.jpg"); // Carrega própria imagem
  img.resize(width, height); // Redimensiona a imagem para o tamanho da janela
  image(img, 0, 0);
  loadPixels();  
  
  // Declaração das máscaras de Sobel
float[][] sobelX = {
  {-1, 0, 1},
  {-2, 0, 2},
  {-1, 0, 1}
};

float[][] sobelY = {
  {-1, -2, -1},
  {0, 0, 0},
  {1, 2, 1}
};

  // Cria uma nova imagem para armazenar as bordas detectadas
  bordasSobel = createImage(width, height, RGB);
  // Aplica o filtro de Sobel
  for (int y = 1; y < height - 1; y++) {
    for (int x = 1; x < width - 1; x++) {
      float sumX = 0;
      float sumY = 0;
      
      // Aplica as máscaras de Sobel para cada pixel
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          color c = img.get(x + i, y + j);
          float gray = brightness(c);
          sumX += sobelX[i + 1][j + 1] * gray;
          sumY += sobelY[i + 1][j + 1] * gray;
        }
      }      
      // Combinação os gradientes x e y
      float gradient = sqrt(sumX * sumX + sumY * sumY);
      gradient = constrain(gradient, 0, 255); // Limita o valor do gradiente entre 0 e 255
      int c = color(gradient);
      bordasSobel.pixels[y * width + x] = c;
    }
  }
  bordasSobel.updatePixels(); // pixels atualizados
  image(bordasSobel, 0, 0); // Exibe a imagem de bordas
  bordasSobel.save("imagem_bordas_Sobel.jpg"); // Salva a imagem de bordas
}
