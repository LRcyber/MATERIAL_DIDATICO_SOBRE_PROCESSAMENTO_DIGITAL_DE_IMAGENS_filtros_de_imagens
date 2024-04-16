PImage img;

void setup() {
  size(640, 480);
  img = loadImage("Bikesgray.jpg"); // carrega imagem
  img.resize(width, height); // Redimensione a imagem para o tamanho da janela
  image(img, 0, 0);
  loadPixels();
  
  // Máscaras de Robert Cross para detecção de bordas
  float[][] robertsX = {
    {1, 0},
    {0, -1}
  };
  
  float[][] robertsY = {
    {0, 1},
    {-1, 0}
  };
  
  // Criar uma nova imagem para armazenar as bordas detectadas
  PImage bordas = createImage(width, height, RGB);
  
  // Aplicando o filtro de Robert Cross
  for (int y = 0; y < height - 1; y++) { //<>//
    for (int x = 0; x < width - 1; x++) {
      float sumX = 0;
      float sumY = 0;
      
      // Aplicando as máscaras de Robert Cross para cada pixel
      for (int i = 0; i <= 1; i++) {
        for (int j = 0; j <= 1; j++) {
          color c = img.get(x + i, y + j);
          float gray = brightness(c);
          sumX += robertsX[i][j] * gray;
          sumY += robertsY[i][j] * gray;
        }
      }      
      // Calculando o gradiente
      float gradient = sqrt(sumX * sumX + sumY * sumY);
      int c = color(gradient);
      bordas.pixels[y * width + x] = c;
    }
  }  
  bordas.updatePixels();
  image(bordas, 0, 0); // Exibe a imagem com as bordas detectadas
  
  // Salva a nova imagem com as bordas detectadas
  bordas.save("imagem_borda_Cross.jpg");
}
