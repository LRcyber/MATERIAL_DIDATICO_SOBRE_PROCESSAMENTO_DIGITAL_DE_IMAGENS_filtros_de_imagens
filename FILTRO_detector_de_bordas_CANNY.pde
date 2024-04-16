PImage originalImage;
PImage bordasImage;

void setup() {
  size(640, 480);
  originalImage = loadImage("maquina_color.png");
  
  
  bordasImage = aplicarFiltroCanny(originalImage);  // Aplica o filtro de Canny
  
  bordasImage.save("maquina_color_canny.jpg");// Salva a imagem com as bordas detectadas
  
  // Exibe a imagem original e a imagem com as bordas detectadas
  image(originalImage, 0, 0);
  image(bordasImage, width/2, 0);   
  noLoop();
}

PImage aplicarFiltroCanny(PImage img) {
  img.loadPixels();
  PImage bordas = createImage(img.width, img.height, RGB);
  bordas.loadPixels();
  
  float[][] kernelX = {
    {-1, 0, 1},
    {-2, 0, 2},
    {-1, 0, 1}
  };
  
  float[][] kernelY = {
    {-1, -2, -1},
    {0, 0, 0},
    {1, 2, 1}
  };
  
  float limiarBaixo = 10;
  float limiarAlto = 100;
  
  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      float valorX = 0;
      float valorY = 0;
      
      for (int j = -1; j <= 1; j++) {
        for (int i = -1; i <= 1; i++) {
          int xx = constrain(x + i, 0, img.width - 1);
          int yy = constrain(y + j, 0, img.height - 1);
          int loc = xx + yy * img.width;
          float gray = brightness(img.pixels[loc]);
          valorX += kernelX[j + 1][i + 1] * gray;
          valorY += kernelY[j + 1][i + 1] * gray;
        }
      }      
      float magnitude = sqrt(valorX * valorX + valorY * valorY); 
      
      if (magnitude > limiarAlto) {
        
        bordas.pixels[x + y * bordas.width] = color(255);               
      } else if (magnitude > limiarBaixo) {
        bordas.pixels[x + y * bordas.width] = color(1);
      } else {
        bordas.pixels[x + y * bordas.width] = color(0);
      }
    }
  }
  
  bordas.updatePixels();
  return bordas;
}
