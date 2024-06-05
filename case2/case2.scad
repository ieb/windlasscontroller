$fn=100;
module aaaBattery() {
    cylinder(d=10.5,h=44);
    translate([12,0,0])
    cylinder(d=10.5,h=44);
}

module aaBattery() {
    translate([8,0,0])
    cylinder(d=14.5,h=50.5);
    translate([-8,0,0])
    cylinder(d=14.5,h=50.5);
}

module cr123ABattery() {
    cylinder(d=17,h=35);
}

module cr2Battery() {
translate([0,0,0])
rotate([90,0,0])
    cylinder(d=15.6,h=27);
}
module switch(on=0,w=6,h=6) {
    cylinder(d=3.3,h=h-(on*0.8));
    translate([0,0,2]) {
        cube([w+0.3,w+0.3,4], center=true);
    }
}

module onoff(on=0) {
    cylinder(d=4,h=14-(3.5*on));
    translate([0,0,3.5]) {
        cube([7,7,7], center=true);
    }
}

module button(value) {
    difference() {
        union() {
            cylinder(d=17,h=1);
            cylinder(d=12,h=4);
            translate([0,0,4])
            scale([1,1,0.1])
               sphere(d=12);
            translate([0,0,4])
                linear_extrude(1)
                    text(value, size=5,  halign="center", valign="center");

        };
        //cylinder(d=5,h=2);
    }
}
module onoffButton() {
    difference() {
        union() {
            cylinder(d=10,h=1);
            cylinder(d=6,h=10);
            translate([0,0,9])
            scale([1,1,0.1])
               sphere(d=6);
        };
        cylinder(d=3,h=3);
        //cube([100,100,100]);
    }
}

module jdy40() {
    translate([0,0,2.5]) 
    cube([14,22,1],center=true);
}

module led() {
   translate([0,0,0])
   cylinder(d=2,h=12);
}
    


module board2() {
   translate([0,0,-2]) {
           
        translate([0,0,-1])
           cube([36,102,2],center = true);
       
   // top surface of the board is datum
         on = 0;
        translate([0,5,0]) {
           switch(on);
           translate([0,0,6.1-(on*0.8)])
               button("D");
         }
         translate([0,30,0]) {
           switch(on);  
           translate([0,0,6.1-(on*0.8)])
               button("U");
         }

         
         translate([0,17,-1.5])
           rotate([0,0,90])
               jdy40();
         
         translate([0,-44,-5.5]) {
             rotate([90,0,0]) {
                onoff(on);
                translate([0,0,11.5-(on*3.5)])
                    onoffButton();
             }
         }
         
         translate([0,44,0])
            led();
         
         translate([0,-4,-2])
          rotate([90,0,0])
            cr123ABattery();

       }
   
}


module case2() {
   difference() {
translate([0,55,-5])
  rotate([90,0,0])  {
 difference() {
     
      hull() {
          
       union() {   
        translate([0,0,55]) {
        cylinder(d=25,h=55);
        translate([18,8,0])
            cylinder(d=10,h=55);    
        translate([-18,8,0])
            cylinder(d=10,h=55);
        translate([18,4,0])
            cylinder(d=10,h=55);    
        translate([-18,4,0])
            cylinder(d=10,h=55);
        }
        
        translate([0,0,10]) {
              cylinder(d=10,h=55);
        }
        translate([18,8,0])
            cylinder(d=10,h=110);    
        translate([-18,8,0])
            cylinder(d=10,h=110);
        translate([18,4,0])
            cylinder(d=10,h=110);    
        translate([-18,4,0])
            cylinder(d=10,h=110);
        
           
       }
   
      }
      translate([0,0,55])    
      hull() {
        cylinder(d=18,h=56);
        translate([18,8,0])
            cylinder(d=6,h=56);    
        translate([-18,8,0])
            cylinder(d=6,h=56);
        translate([18,4,0])
            cylinder(d=6,h=56);    
        translate([-18,4,0])
            cylinder(d=6,h=56);
      }    
      translate([0,0,3])    
      hull() {
        translate([18,8,0])
            cylinder(d=6,h=55);    
        translate([-18,8,0])
            cylinder(d=6,h=55);
        translate([18,1,0])
            cylinder(d=1,h=55);    
        translate([-18,1,0])
            cylinder(d=1,h=55);
      }
      
      // screw holes
          translate([20,7,106])
          rotate([0,90,0])
              cylinder(d=2,h=10, center=true);
          translate([-20,7,106])
          rotate([0,90,0])
              cylinder(d=2,h=10, center=true);
    }


  }
  board2();
  }
}

module cap() {
translate([0,-55,-5])
  rotate([90,0,0]) {
      difference() {
      union() {

          hull() {
            cylinder(d=25,h=6);
            translate([18,8,0])
                cylinder(d=10,h=6);    
            translate([-18,8,0])
                cylinder(d=10,h=6);
            translate([18,4,0])
                cylinder(d=10,h=6);    
            translate([-18,4,0])
                cylinder(d=10,h=6);
       
          }
          translate([0,0,-8])    
          hull() {
            cylinder(d=18,h=13);
            translate([18,8,0])
                cylinder(d=6,h=13);    
            translate([-18,8,0])
                cylinder(d=6,h=13);
            translate([18,4,0])
                cylinder(d=6,h=13);    
            translate([-18,4,0])
                cylinder(d=6,h=13);
          } 
        }
        // button hole
        translate([0,-2.5,-9])
        cylinder(h=11,d=11);
        translate([0,-2.5,-8])
        cylinder(h=20,d=6);

        // board cutout
        translate([0,2.2,-8])
        cube([40,3,10], center=true);
        
        // scrw holes
        translate([20,7,-4])
          rotate([0,90,0])
              cylinder(d=2,h=10, center=true);
          translate([-20,7,-4])
          rotate([0,90,0])
              cylinder(d=2,h=10, center=true);

        // lanyard
        translate([00,7,2.5])
          rotate([0,90,0])
              cylinder(d=3,h=60, center=true);

        
    }
        
  }   
}

/*
board2();


difference()  {
    union() {
   cap();
   case2();
    }
  translate([0,-75,-75])
     cube([150,150,150]);
}
*/

//cap();
case2();
//button("D");
//button("U");
//onoffButton();
