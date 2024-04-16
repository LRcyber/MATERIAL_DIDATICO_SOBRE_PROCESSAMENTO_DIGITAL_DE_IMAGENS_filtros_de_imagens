PImage img;
PImage bordasR, bordasG, bordasB;

void setup() {
  size(800, 600);
  
  // Carregar a imagem de entrada
  img = loadImage("tucano_color.jpg");
  
  // Criar imagens para armazenar as bordas detectadas nos canais R, G e B
  bordasR = createImage(img.width, img.height, RGB);
  bordasG = createImage(img.width, img.height, RGB);
  bordasB = createImage(img.width, img.height, RGB);
  
  // Detecta as bordas nos canais R, G e B
  detectarBordasRGB();
  
  // Exibir a imagem original
  image(img, 0, 0);
  
  // Exibir as imagens com as bordas detectadas nos canais R, G e B
 /* image(bordasR, width/3, 0);
  image(bordasG, 2 * width/3, 0);*/
  
  // Salvar as imagens com as bordas detectadas
  bordasR.save("imagem_bordas_R.jpg");
  bordasG.save("imagem_bordas_G.jpg");
  bordasB.save("imagem_bordas_B.jpg");
}

void detectarBordasRGB() {
  img.loadPixels();
  bordasR.loadPixels();
  bordasG.loadPixels();
  bordasB.loadPixels();
  
  for (int x = 1; x < img.width - 1; x++) {
    for (int y = 1; y < img.height - 1; y++) {
      // Obter as cores dos pixels vizinhos
      color c1 = img.get(x - 1, y - 1);
      color c2 = img.get(x + 1, y + 1);
      
      // Calcula a diferença entre os valores dos canais R, G e B dos pixels vizinhos
      int diffR = (int) (red(c1) - red(c2));
      int diffG = (int) (green(c1) - green(c2));
      int diffB = (int) (blue(c1) - blue(c2));
      
      // Definir o valor dos pixels resultantes nas imagens de bordas
      bordasR.set(x, y, color(abs(diffR), 0, 0));
      bordasG.set(x, y, color(0, abs(diffG), 0));
      bordasB.set(x, y, color(0, 0, abs(diffB)));
    }
  }
  
  bordasR.updatePixels();
  bordasG.updatePixels();
  bordasB.updatePixels();
}
