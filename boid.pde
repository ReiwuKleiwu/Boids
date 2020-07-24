import java.util.*;

public class Boid
{
  PVector coords = new PVector();
  PVector dir = new PVector();
  PVector acceleration = new PVector();
  int maxForce;
  int maxSpeed; 
  int velocityRate;
  String id; 
  int quadrant; 
  int radius;
  int cohesionRadius;
  int separationRadius;

  ArrayList<Boid> intersectingCohesionBoids = new ArrayList<Boid>();
  ArrayList<Boid> intersectingSeperationBoids = new ArrayList<Boid>();

  PVector cohesionValue = new PVector(); 
  PVector separationValue = new PVector();
  PVector alignmentValue = new PVector(); 

  float cohesionWeight; 
  float separationWeight;
  float alignmentWeight;
  
  int selectedOperation; 
  int keyPressedCount = 0;

  public Boid(int x, int y, String ID)
  {
    this.coords.x = x; 
    this.coords.y = y; 
    this.id = ID; 
    this.maxForce = 1; 
    this.maxSpeed = 4; 
    this.quadrant = 0;
    this.velocityRate = 2; 
    this.radius = 5; 
    this.cohesionRadius = 100; 
    this.separationRadius = 20; 
    this.cohesionWeight = 1;
    this.separationWeight = 1; 
    this.alignmentWeight = 1;
  }

  public void spawn()
  {
    strokeWeight(5);
    stroke(238, 77, 49);
    point(this.coords.x, this.coords.y);
  }


  public void update()
  {
    
    this.cohesionValue.mult(this.cohesionWeight);
    this.separationValue.mult(this.separationWeight);
    this.alignmentValue.mult(this.alignmentWeight);


    this.acceleration.add(this.alignmentValue);
    this.acceleration.add(this.cohesionValue);
    this.acceleration.add(this.separationValue);

    this.coords.add(this.dir.mult(this.velocityRate));
    this.dir.add(this.acceleration);
    this.dir.limit(this.maxSpeed);
    this.acceleration.mult(0);
    this.dir.normalize();
    

    if (this.coords.x > 800) {
      this.coords.x = -800;
    } else if (this.coords.x < (-800)) {
      this.coords.x = 800;
    } else if (this.coords.y > 450) {
      this.coords.y = -450;
    } else if (this.coords.y < (-450)) {
      this.coords.y = 450;
    }

    strokeWeight(5);
    stroke(238, 77, 49);
    point(this.coords.x, this.coords.y);
  }


  public Boolean intersectionSeperationCheck(Boid boid) {
    
    float d = dist(this.coords.x, this.coords.y, boid.coords.x, boid.coords.y);
    if (d < this.separationRadius + boid.radius) {

      if (this.intersectingSeperationBoids.contains(boid)) {
   
        return true;
      } else {

        this.intersectingSeperationBoids.add(boid);
        
        return true;
      }
    } else {
      if (this.intersectingSeperationBoids.contains(boid)) {
        int index = this.intersectingSeperationBoids.indexOf(boid);
        //System.o.println(index);
        this.intersectingSeperationBoids.remove(index);
        //System.out.println(this.intersectingSeperationBoids.size());
        //System.out.println(this.intersectingSeperationBoids);
      }
      return false;
    }
    
  }


  public Boolean intersectionCohesionCheck(Boid boid) {


    float d = dist(this.coords.x, this.coords.y, boid.coords.x, boid.coords.y);
    if (d < this.cohesionRadius + boid.radius) {

      if (this.intersectingCohesionBoids.contains(boid)) {

        return true;
      } else {

        this.intersectingCohesionBoids.add(boid);
        return true;
      }
    } else {
      if (this.intersectingCohesionBoids.contains(boid)) {
        int index = this.intersectingCohesionBoids.indexOf(boid);
        this.intersectingCohesionBoids.remove(index);
      }
      return false;
    }
  }
  
  public void changeParams()
  {
    
    if(keyPressed)
    {
      this.keyPressedCount++;
      if(key == 'q' && this.keyPressedCount > 5)
      {
        
        this.cohesionWeight += 0.1;
        this.keyPressedCount = 0;
        

      }
      else if(key == 'a' && this.keyPressedCount > 5)
      {
        if(this.cohesionWeight > 0.1)
        {
        this.cohesionWeight -= 0.1;
        this.keyPressedCount = 0;
        }
      }
      else if(key == 'w' && this.keyPressedCount > 5)
      {
        this.separationWeight += 0.1;
        this.keyPressedCount = 0;
      }
      else if(key == 's' && this.keyPressedCount > 5)
      {
        if(this.separationWeight > 0.1)
        {
        this.separationWeight -= 0.1;
        this.keyPressedCount = 0;
        }
      }
      else if(key == 'e' && this.keyPressedCount > 5)
      {
        this.alignmentWeight += 0.1;
        this.keyPressedCount = 0;
      }
      else if(key == 'd' && this.keyPressedCount > 5)
      {
        if(this.alignmentWeight > 0.1)
        {
        this.alignmentWeight -= 0.1;
        this.keyPressedCount = 0;
        }
      }
      else if(key == 'r' && this.keyPressedCount > 5)
      {
        this.cohesionRadius += 2;
        this.keyPressedCount = 0;
      }
      else if(key == 'f' && this.keyPressedCount > 5)
      {
        this.cohesionRadius -= 2;
        this.keyPressedCount = 0;
      }
      else if(key == 't' && this.keyPressedCount > 5)
      {
        this.separationRadius += 2;
        this.keyPressedCount = 0;
      }
      else if(key == 'g' && this.keyPressedCount > 5)
      {
        this.separationRadius -= 2;
        this.keyPressedCount = 0;
      }
    }
    

  }


  public void drawSeperationLine(Boid boid) {
    strokeWeight(1);
    stroke(92, 184, 92);
    line(this.coords.x, this.coords.y, boid.coords.x, boid.coords.y);
  }

  public void drawCohesionLine(Boid boid) {
    strokeWeight(1);
    stroke(255, 0, 130);
    line(this.coords.x, this.coords.y, boid.coords.x, boid.coords.y);
  }

  public void drawDirectionLine() {
    strokeWeight(2);
    stroke(238, 77, 49);
    
    line(this.coords.x, this.coords.y, this.coords.x + this.dir.x * 10, this.coords.y + this.dir.y * 10);
  }

  public void drawCohesionRadius() {
    strokeWeight(2);
    stroke(0, 143, 255);
    noFill();
    circle(this.coords.x, this.coords.y, this.cohesionRadius);
  }

  public void drawSeperationRadius() {
    strokeWeight(2);
    stroke(247, 197, 22);
    noFill();
    circle(this.coords.x, this.coords.y, this.separationRadius);
  }

  public void separation() {

    if (this.intersectingSeperationBoids.size() > 0) {
      PVector steering = new PVector();



      for (Boid boid : this.intersectingSeperationBoids)
      {
        float d = dist(
          this.coords.x, 
          this.coords.y, 
          boid.coords.x, 
          boid.coords.y
          );

        PVector diff = PVector.sub(this.coords, boid.coords);
        if (d * d > 0) {
          diff.div(d * d);
        }

        steering.add(diff);
      }


      steering.div(this.intersectingSeperationBoids.size());
      

      steering.setMag(this.maxSpeed);
      steering.sub(this.dir);
      steering.limit(this.maxForce);

      this.separationValue = steering;
    }
  }


  public void alignment() {

    PVector steering = new PVector();


    for (Boid boid : this.intersectingSeperationBoids)
    {
      steering.add(boid.dir);
    };


    if (this.intersectingSeperationBoids.size() > 0) {
      steering.div(this.intersectingSeperationBoids.size());
      steering.setMag(this.maxSpeed);
      steering.sub(this.dir);
      steering.limit(this.maxForce);

    this.alignmentValue = steering;
  }
  }
  public void cohesion() {

    PVector steering = new PVector();

    if (this.intersectingCohesionBoids.size() > 0) {
      for (Boid boid : this.intersectingCohesionBoids) {
        steering.add(boid.coords);
      }

      steering.div(this.intersectingCohesionBoids.size());
      steering.sub(this.coords);
      steering.setMag(this.maxSpeed);
      steering.sub(this.dir);
      steering.limit(this.maxForce);

      this.cohesionValue = steering;
    }
  }
}
