PImage img;

void setup() {
  size(400, 530);
  img = loadImage("Sunflowers_in_July.jpg"); // Carrega a imagem
  img.resize(width, height); // Redimensiona a imagem para o tamanho do canvas
  image(img, 0, 0); // Exibe a imagem original
  
  loadPixels(); // Carrega os pixels da imagem
  
  PImage grayImg = createImage(width, height, RGB); // Cria uma nova imagem em tons de cinza
  
  // Transforma a imagem em tons de cinza
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int loc = x + y * width;
      color c = img.pixels[loc];
      float grayValue = (red(c) + green(c) + blue(c)) / 3.0; // Calcula a média dos valores de RGB
      grayImg.pixels[loc] = color(grayValue, grayValue, grayValue);
    }
  }
  
  grayImg.updatePixels(); // Atualiza os pixels da imagem em tons de cinza
  
  // Aplica o filtro Deriche para detecção de bordas na imagem em tons de cinza
  float[][] deriche = {
    {-1, -1, -1},
    {-1,  8, -1},
    {-1, -1, -1}
  };
  
  PImage newImg = createImage(width, height, RGB); // Cria uma nova imagem para armazenar o resultado
  
  for (int x = 1; x < width - 1; x++) {
    for (int y = 1; y < height - 1; y++) {
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      int offset = (y * width + x);
      
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int grayPix = grayImg.pixels[offset + j + i * width];
          float factor = deriche[j + 1][i + 1];
          sumR += red(grayPix) * factor;
          sumG += green(grayPix) * factor;
          sumB += blue(grayPix) * factor;
        }
      }
      
      sumR = constrain(sumR, 0, 255);
      sumG = constrain(sumG, 0, 255);
      sumB = constrain(sumB, 0, 255);
      
      newImg.pixels[offset] = color(sumR, sumG, sumB); // Armazena o pixel na nova imagem
    }
  }
  
  newImg.updatePixels(); // Atualiza os pixels da nova imagem
  newImg.save("Sunflowers_in_July_DERICHE.jpg"); // Salva a nova imagem
}
