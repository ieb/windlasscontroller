$fn=100;




module board() {
    difference() {
    union() {
       translate([0,0,1])
        cube([60,81,2], center=true);
       // connectors
        color("blue") {
       translate([(30-17),40-9.8,15/2])
        cube([10,7.5,12], center=true);
       translate([(30-32),40-9.8,15/2])
        cube([10,7.5,12], center=true);
       // relays
       translate([(30-12),40-34,17/2])
        cube([19,19,17],center=true); 
       translate([(30-31),40-34,17/2])
        cube([19,19,17],center=true); 
        }
        
       
        // button
       translate([30-6,40-69,0])
         cylinder(d=3,h=14);
        // button
       translate([30-24,40-69,0])
         cylinder(d=3,h=14);

        // led
       translate([30-3,40-62,0])
         cylinder(d=2,h=14);
       translate([30-21,40-62,0])
         cylinder(d=2,h=14);
       
       
        
        }
    }
}
module lid(w=78,d=95,h=14,t=2) {
   difference() {
     translate([0,0,12+h/2-(t/2)]) 
      difference() {
        union() {
            difference() {
                union() {
                    cube([w-t*2,d,h], center=true);
                    cube([w,d-t*2,h], center=true);
                    translate([w/2-t,d/2-t,0])
                    cylinder(r=t,h=h, center=true);
                    translate([-(w/2-t),d/2-t,0])
                    cylinder(r=t,h=h, center=true);
                    translate([-(w/2-t),-(d/2-t),0])
                    cylinder(r=t,h=h, center=true);
                    translate([w/2-t,-(d/2-t),0])
                    cylinder(r=t,h=h, center=true);
                    

                }
                // inside
                translate([0,0,-t*2])
                    cube([w-t*2,d-t*2,h+t*2], center=true);
            }
            
            
           translate([-20,41.5,-2.5]) 
            cube([5,8,19], center=true);
           translate([20,41.5,-2.5]) 
            cube([5,8,19], center=true);

            
            // fxings
            translate([w/2-2*t,d/2-2*t,0])
                    cylinder(r=5,h=h, center=true);
            translate([-(w/2-2*t),d/2-2*t,0])
                    cylinder(r=5,h=h, center=true);
            translate([-(w/2-2*t),-(d/2-2*t),0])
                    cylinder(r=5,h=h, center=true);
                    translate([w/2-2*t,-(d/2-2*t),0])
                    cylinder(r=5,h=h, center=true);
        }
        
            translate([w/2-2*t,d/2-2*t,0])
                    cylinder(d=3,h=h+10, center=true);
            translate([-(w/2-2*t),d/2-2*t,0])
                    cylinder(d=3,h=h+10, center=true);
            translate([-(w/2-2*t),-(d/2-2*t),0])
                    cylinder(d=3,h=h+10, center=true);
                    translate([w/2-2*t,-(d/2-2*t),0])
                    cylinder(d=3,h=h+10, center=true);
    }
      cables();
    


        // button
       translate([30-6,40-69,0])
         cylinder(d=6,h=44);
        // button
       translate([30-24,40-69,0])
         cylinder(d=6,h=44);

        // led
       translate([30-3,40-62,0])
         cylinder(d=3,h=44);
       translate([30-21,40-62,0])
         cylinder(d=3,h=44);

       


    }

}

module case(w=78,d=95,h=12,t=2) {
   difference() {
   translate([0,0,(h/2)-(t/2)]) 
      difference() {
        union() {
            difference() {
                union() {
                    cube([w-t*2,d,h], center=true);
                    cube([w,d-t*2,h], center=true);
                    translate([w/2-t,d/2-t,0])
                    cylinder(r=t,h=h, center=true);
                    translate([-(w/2-t),d/2-t,0])
                    cylinder(r=t,h=h, center=true);
                    translate([-(w/2-t),-(d/2-t),0])
                    cylinder(r=t,h=h, center=true);
                    translate([w/2-t,-(d/2-t),0])
                    cylinder(r=t,h=h, center=true);
                    

                }
                // inside
                translate([0,0,t])
                    cube([w-t*2,d-t*2,h+t], center=true);
            }
            
             // pillars
            difference() {
            translate([0,-40.5,0])
            cube([50,5,10], center=true);
                translate([0,-38,0])            
                cube([55,5,3], center=true);
            }
            difference() {
                translate([0,40.5,-2])            
                cube([50,10,6], center=true);
                translate([0,38,0.5])            
                cube([55,5,4], center=true);
            }

            // fxings
            translate([w/2-2*t,d/2-2*t,0])
                    cylinder(r=5,h=h, center=true);
            translate([-(w/2-2*t),d/2-2*t,0])
                    cylinder(r=5,h=h, center=true);
            translate([-(w/2-2*t),-(d/2-2*t),0])
                    cylinder(r=5,h=h, center=true);
                    translate([w/2-2*t,-(d/2-2*t),0])
                    cylinder(r=5,h=h, center=true);
        }
        
            translate([w/2-2*t,d/2-2*t,0])
                    cylinder(d=3,h=h+10, center=true);
            translate([-(w/2-2*t),d/2-2*t,0])
                    cylinder(d=3,h=h+10, center=true);
            translate([-(w/2-2*t),-(d/2-2*t),0])
                    cylinder(d=3,h=h+10, center=true);
                    translate([w/2-2*t,-(d/2-2*t),0])
                    cylinder(d=3,h=h+10, center=true);
        }
        cables();
        
        
    }
}
module cables() {
    /*
    translate([-90,-15,10])
    rotate([0,90,0])
    cylinder(d=2,h=90);
    
    translate([-90,15,10])
    rotate([0,90,0])
    cylinder(d=4,h=90);
*/
            translate([13,0,11])
            rotate([-90,0,0])
                cylinder(d=5.5,h=55);

            translate([-2,0,11])
            rotate([-90,0,0])
                cylinder(d=5.5,h=55);


/*
    translate([-90,0,0])
    rotate([0,90,0])
    cylinder(d=4,h=90);

    color("red")
    translate([0,0,0])
    rotate([0,90,0])
    cylinder(d=7,h=90);
    */
}





difference() {
    union() {
        translate([0,0,4]) 
        board();
        color("blue") case();
        lid();
         //cables();
    }
   //translate([40,0,0])
   //cube([80,160,140], center=true);
}


//cables();
//translate([0,0,0]) 
//board();
//color("blue") case();
//lid();
//cables();
