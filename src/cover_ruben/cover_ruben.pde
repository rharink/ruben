float ultimate_radius = 120.0;
float a_radius = 640.0;

// standard deviation of projection points.
float sd_p = 200.0;

float p_rand_low = 300;
float p_rand_high = 400;

float cx = 0.0;
float cy = 0.0;

// teta
float tv = TWO_PI/150;
float t1 = 0.0;
float t2 = 0.0;
float t3 = 0.0;

// radius velocity
float rv = 1.0;

// anchor points
PVector a1 = new PVector(0,0);
PVector a2 = new PVector(0,0);
PVector a3 = new PVector(0,0);

// projection points
PVector p1 = new PVector(0,0);
PVector p2 = new PVector(0,0);
PVector p3 = new PVector(0,0);

void setup() {
  size(1000, 1000); //<>//
  cx = width/2;
  cy = height/2;

  t1 = random(TWO_PI);
  t2 = t1 + TWO_PI/3 + random(TWO_PI/-10, TWO_PI/10);
  t3 = t1 + TWO_PI/-3 + random(TWO_PI/-10, TWO_PI/10);
  
  a1 = pointOnCircle(cx, cy, a_radius, t1);
  a2 = pointOnCircle(cx, cy, a_radius, t2);
  a3 = pointOnCircle(cx, cy, a_radius, t3);
  
  float raar = random(p_rand_low, p_rand_high);
  
  p1 = pointOnCircle(cx, cy, raar + random(-50,50), t1);
  p2 = pointOnCircle(cx, cy, raar + random(-50,50), t2);
  p3 = pointOnCircle(cx, cy, raar + random(-50,50), t3);
}

void draw() {
  rv = rv * 1.05;
  tv = tv;
  p1 = swirl(p1, tv, rv, new PVector(cx, cy));
  p2 = swirl(p2, tv, rv, new PVector(cx, cy));
  p3 = swirl(p3, tv, rv, new PVector(cx, cy));
  println(p1);
  
  clear();
  background(200, 200, 200);
  fill(255, 255, 255);
  circle(cx, cy, ultimate_radius);

  // Imaginary circle 1
  noFill();
  circle(cx, cy, a_radius);
  
  fill(255,0,0);
  circle(a1.x, a1.y, 20);
  circle(a2.x, a2.y, 20);
  circle(a3.x, a3.y, 20);
  
  fill(0,255,0);
  circle(p1.x, p1.y, ultimate_radius);
  circle(p2.x, p2.y, ultimate_radius);
  circle(p3.x, p3.y, ultimate_radius);
  
  stroke(0,0,0);
  line(a1.x, a1.y, p1.x, p1.y);
  line(a2.x, a2.y, p2.x, p2.y);
  line(a3.x, a3.y, p3.x, p3.y);
}

PVector swirl(PVector p, float tv, float rv, PVector center) {
  float t1_temp = atan2(-center.y + p.y, -center.x + p.x);
  float r1_temp = sqrt(pow(-center.y + p.y, 2) + pow(-center.x + p.x, 2));
  
  float r = max(r1_temp - rv, 0);
  float t = t1_temp - tv;
  println("r1_temp,", r1_temp);
  println("r,", r);
  return new PVector(center.x + r * cos(t), center.y + r * sin(t));
}

PVector pointOnCircle(float x, float y, float r, float t) {
  return new PVector(x + (r/2) * cos(t), y + (r/2) * sin(t));
}

PVector pointAroundCenter(float x, float y, float sd) {
   float rx = abs(randomGaussian());
   float ry = abs(randomGaussian());
   return new PVector(x + sd*rx, y + sd*ry);
}
