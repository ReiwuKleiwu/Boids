
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

ArrayList<Boid> boidArray = new ArrayList<Boid>();
int boidCount = 50; 

ArrayList<Boid> quadrant1 = new ArrayList<Boid>();
ArrayList<Boid> quadrant2 = new ArrayList<Boid>();
ArrayList<Boid> quadrant3 = new ArrayList<Boid>();
ArrayList<Boid> quadrant4 = new ArrayList<Boid>();

Boolean cohesionRadius = false;
Boolean separationRadius = false;
Boolean directionLines = false;
int keyPressedCount = 0;
Boolean cohesionLines = false; 
Boolean separationLines = false; 

int aiStep = 1; 
int counter = 0; 



void setup()
{
  size(1600, 900);
  frameRate(144);
  
}

void draw()
{
  background(22, 22, 24);
  translate(800, 450);
  stroke(255, 255, 255);
 
  
  if(keyPressed){
  keyPressedCount++; 
  if(key == 'y' && cohesionRadius == false && keyPressedCount > 15)
  {
    cohesionRadius = true;
    keyPressedCount = 0;
  }
  else if((key == 'y') && cohesionRadius == true  && keyPressedCount > 15)
  {
    cohesionRadius = false;
    keyPressedCount = 0;
  }
  if(key == 'x' && separationRadius == false  && keyPressedCount >15)
  {
    separationRadius = true;
    keyPressedCount = 0;
  }
  else if(key == 'x' && separationRadius == true  && keyPressedCount > 15)
  {
    separationRadius = false;
    keyPressedCount = 0;
  }
  
  if(key == 'c' && directionLines == false  && keyPressedCount > 15)
  {
    directionLines = true;
    keyPressedCount = 0;
  }
  else if(key == 'c' && directionLines == true  && keyPressedCount > 15)
  {
    directionLines = false; 
    keyPressedCount = 0;
  }
  if(key == 'v' && separationLines == false  && keyPressedCount > 15)
  {
    separationLines = true;
    keyPressedCount = 0;
  }
  else if(key == 'v' && separationLines == true  && keyPressedCount > 15)
  {
    separationLines = false; 
    keyPressedCount = 0;
  }
  if(key == 'b' && cohesionLines == false  && keyPressedCount > 15)
  {
    cohesionLines = true;
    keyPressedCount = 0;
  }
  else if(key == 'b' && cohesionLines == true  && keyPressedCount > 15)
  {
    cohesionLines = false; 
    keyPressedCount = 0;
  }
  }
  
 
  boidSpawner();
  
  /*
  System.out.println("Quadrant1: " + quadrant1.size());
  System.out.println("Quadrant2: " + quadrant2.size());
  System.out.println("Quadrant3: " + quadrant3.size());
  System.out.println("Quadrant4: " + quadrant4.size());
  System.out.println("Sum: " + (quadrant1.size() + quadrant2.size() + quadrant3.size() + quadrant4.size()));
  System.out.println("---------------------------------");
  */
   textSize(20);
 
 
 if(counter == aiStep)
 {
    
  for(Boid boid : boidArray)
  {
    
    selectQuadrant(boid);
    quadrantIntersectionCheck(boid); 
    boid.alignment();
    boid.cohesion();
    boid.separation();
    
  }
  counter = 0;
 }
 counter++;
 

  for(Boid boid : boidArray)
  {
     boid.update();
       boid.changeParams();
    
    if(directionLines)
    {
      boid.drawDirectionLine();
    }
    if(cohesionRadius)
    {
      boid.drawCohesionRadius();      
    }
    if(separationRadius)
    {
      boid.drawSeperationRadius();
    }
  }

    text("Cohesion Weight: " + boidArray.get(0).cohesionWeight, 520, -400);
    text("Separation Weight: " + boidArray.get(0).separationWeight, 520, -380);
    text("Alignment Weight: " + boidArray.get(0).alignmentWeight, 520, -360);
    text("Cohesion Radius: " + boidArray.get(0).cohesionRadius, 520, -340);
    text("Separation Radius: " + boidArray.get(0).separationRadius, 520, -320);
    text("Alignment Radius: " + boidArray.get(0).separationRadius, 520, -300);
    text("Frame Rate: " + frameRate, 520, -280);

 
  
}

void boidSpawner()
{
  if(boidArray.size() < boidCount)
  {
    
    for(int i = 0; i < boidCount; i++)
    {
      Boid fogel = new Boid(getRandomInt(-600, 600), getRandomInt(-250, 250), makeID(6));
      fogel.spawn();
      boidArray.add(fogel);
    }
  }
  
}

public String makeID(int l)
{
      String text = "";
      String char_list = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      
      for(int i = 0; i < l; i++)
      {
        text += char_list.charAt((int)(Math.random() * char_list.length()));
      }
      
      return text; 
}
    
public void selectQuadrant(Boid boid)
{
    if (boid.quadrant == 0) {

    if (boid.coords.x >= 0 && boid.coords.y >= 0) {
      quadrant1.add(boid);
      boid.quadrant = 1;
    } else if (boid.coords.x <= 0 && boid.coords.y >= 0) {
      quadrant2.add(boid);
      boid.quadrant = 2;
    } else if (boid.coords.x <= 0 && boid.coords.y <= 0) {
      quadrant3.add(boid);
      boid.quadrant = 3;
    } else if (boid.coords.x >= 0 && boid.coords.y <= 0) {
      quadrant4.add(boid);
      boid.quadrant = 4;
    } else {
      System.out.println("COULDN'T FIND FITTING QUADRANT FOR BOID: " + boid.id);
    }
  } else {

    int newQuadrant = 0;
    int index = -1;


    if (boid.coords.x >= 0 && boid.coords.y >= 0) {
      newQuadrant = 1;
    } else if (boid.coords.x <= 0 && boid.coords.y >= 0) {
      newQuadrant = 2;
    } else if (boid.coords.x <= 0 && boid.coords.y <= 0) {
      newQuadrant = 3;
    } else if (boid.coords.x >= 0 && boid.coords.y <= 0) {
      newQuadrant = 4;
    } else {
      System.out.println("COULDN'T FIND FITTING QUADRANT FOR BOID: " + boid.id);
    }

    if (newQuadrant != boid.quadrant) {
      switch (boid.quadrant) {
        case 1:
          index = quadrant1.indexOf(boid);
          quadrant1.remove(index);
          break;
        case 2:
          index = quadrant2.indexOf(boid);
          quadrant2.remove(index);
          break;
        case 3:
          index = quadrant3.indexOf(boid);
          quadrant3.remove(index);
          break;
        case 4:
          index = quadrant4.indexOf(boid);
          quadrant4.remove(index);
          break;
      }

      switch (newQuadrant) {
        case 1:
          quadrant1.add(boid);
          boid.quadrant = 1;
          break;
        case 2:
          quadrant2.add(boid);
          boid.quadrant = 2;
          break;
        case 3:
          quadrant3.add(boid);
          boid.quadrant = 3;
          break;
        case 4:
          quadrant4.add(boid);
          boid.quadrant = 4;
          break;
      }

    }

  }
}
    
    
    
public int getRandomInt(int min, int max)
{  
  int number = (int)((Math.random() * (max-min + 1)) + min); 
   
  return number;
}


public void quadrantIntersectionCheck(Boid boid)
{
  switch (boid.quadrant) {
    case 1:
      for (int i = 0; i < quadrant1.size(); i++) {
        if (boid.intersectionSeperationCheck(quadrant1.get(i))) {
          if(separationLines){
           boid.drawSeperationLine(quadrant1.get(i));   
          }
         
           
        }
        if(boid.intersectionCohesionCheck(quadrant1.get(i)))
        {
          if(cohesionLines){
            boid.drawCohesionLine(quadrant1.get(i));
          }
          
        }
      }
      break;
    case 2:
      for (int i = 0; i < quadrant2.size(); i++) {
        if (boid.intersectionSeperationCheck(quadrant2.get(i))) {
          if(separationLines){
           boid.drawSeperationLine(quadrant2.get(i));   
          }
        }
        if(boid.intersectionCohesionCheck(quadrant2.get(i)))
        {
          if(cohesionLines){
            boid.drawCohesionLine(quadrant2.get(i));
          }
        }
      }
      break;
    case 3:
      for (int i = 0; i < quadrant3.size(); i++) {
        if (boid.intersectionSeperationCheck(quadrant3.get(i))) {
         if(separationLines){
           boid.drawSeperationLine(quadrant3.get(i));   
          }
        }
        if(boid.intersectionCohesionCheck(quadrant3.get(i)))
        {
          if(cohesionLines){
            boid.drawCohesionLine(quadrant3.get(i));
          }
        }
      }
      break;
    case 4:
      for (int i = 0; i < quadrant4.size(); i++) {
        if (boid.intersectionSeperationCheck(quadrant4.get(i))) {
          if(separationLines){
           boid.drawSeperationLine(quadrant4.get(i));   
          }
        }
        if(boid.intersectionCohesionCheck(quadrant4.get(i)))
        {
          if(cohesionLines){
            boid.drawCohesionLine(quadrant4.get(i));
          }
        }
      }
      break;
  }

}
