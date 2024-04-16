PImage img; 
PImage bordasPrewitt;

void setup() {
  size(640, 480);
  img = loadImage("Bikesgray.jpg"); // Carrega imagem 
  img.resize(width, height); // Redimensiona a imagem para o tamanho da janela
  image(img, 0, 0);
  loadPixels();
  
  // Cria duas máscaras de Prewitt para detecção de bordas
  float[][] PrewittlX = {
    {1, 0, -1},
    {1, 0, -1},
    {1, 0, -1}
  };
  
  float[][] PrewittlY = {
    {1, 1, 1},
    {0, 0, 0},
    {-1,-1,-1}
  };
  
  // Cria uma nova imagem para armazenar as bordas detectadas
  bordasPrewitt = createImage(width, height, RGB); // Removido 'PImage' daqui
  
  // Aplica o filtro de Prewitt
  for (int y = 1; y < height - 1; y++) {
    for (int x = 1; x < width - 1; x++) {
      float sumX = 0;
      float sumY = 0;
      
      // Aplica as máscaras de Prewitt para cada pixel
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          color c = img.get(x + i, y + j);
          float gray = brightness(c);
          sumX += PrewittlX[i + 1][j + 1] * gray;
          sumY += PrewittlY[i + 1][j + 1] * gray;
        }
      }
      
      // Combinação os gradientes x e y
      float gradient = sqrt(sumX * sumX + sumY * sumY);
      int c = color(gradient);
      bordasPrewitt.pixels[y * width + x] = c; // Alterado 'pixels' para 'bordasPrewitt.pixels'
    }
  }
  bordasPrewitt.updatePixels(); // Adicionado para garantir que os pixels sejam atualizados
  bordasPrewitt.save("imagem_bordas_Prewitt.jpg");
}
