
PImage img;
PImage imo;
void setup() {
  size(640, 480);
  int i, j;
  color c;
  float r, g, b, d;
  
  String fname = "Bikesgray";
  img = loadImage(fname+".jpg"); 
  PImage imo = createImage(640, 480, RGB);  
  for (i=1; i<=640; i++) {
    for (j=1; j<=480; j++) {
        c = img.get(i,j);
        r = red(c);
        g = green(c);
        b = blue(c);       
        if (r>100){
        imo.set(i,j, color(255,255,255)); }
        else{
        imo.set(i,j, color(0,0,0)); }          
    }        
  }
  imo.save(fname+"-limiariazacao1.jpg");
  exit();
}
