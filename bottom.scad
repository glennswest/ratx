
include <puzzlecutlib/puzzlecutlib.scad>
use <MCAD/nuts_and_bolts.scad>;
use <cgrid.scad>;
use <psuframe.scad>;


$fn=500;
bodysize=140;
insidebody=bodysize-10;
bodyheight=185;

stampSize = [500,500,200];		//size of cutting stamp (should cover 1/2 of object)

cutSize = 4;	//size of the puzzle cuts

xCut1 = [-64, -8, 8, 27, 45, 64];	//locations of puzzle cuts relative to X axis center
yCut1 = [-64, -8, 8, 64];				//for Y axis

kerf = 0;		//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces

module psu_base()
{
import("psu.stl", convexity=3);
}

module mount_bolts(angle)
{
    rotate([0,0,angle]) translate([-25,bodysize-5,bodyheight/2+10]) rotate([90,0,0]) boltHole(5,length=30);
    rotate([0,0,angle]) translate([-25,bodysize-5,bodyheight/2-10]) rotate([90,0,0]) boltHole(5,length=30);

}

module layer_bolts(angle)
{
    rotate([0,0,angle]) translate([0,bodysize,bodyheight+5]) rotate([90,0,0]) boltHole(3,length=15);
}

module bottom_bolts(px,py)
{
    //rotate([0,0,angle]) translate([0,bodysize,-5]) rotate([0,0,0]) boltHole(4,length=15);
    translate([px,py,-11]) rotate([0,0,0]) boltHole(5,length=15);
    translate([px,py,0]) rotate([0,0,0]) nutHole(5,length=15);
}





module cutraidus(h)
{
	difference(){
             cylinder(r=insidebody,h=h);
             translate([insidebody,-insidebody+50,-.2]) rotate([0,0,90]) cube([insidebody*2,insidebody*2,h+.4]);
             }

}


module side_bolts()
{
      mount_bolts(-5);
      mount_bolts(-15);
      mount_bolts(90-5);
      mount_bolts(90-15);
      mount_bolts(180-5);
      mount_bolts(180-15);
      mount_bolts(270-5);
      mount_bolts(270-15);
}

module bodyring()
{
    difference(){
	  cylinder(r=bodysize,h=bodyheight);
      translate([0,0,-.1]) cylinder(r=bodysize-10,h=bodyheight+.2);
      // side_bolts();
      
      }
  difference(){
         translate([0,0,-10]) cylinder(r=bodysize,h=12);
         bottom_bolts(-80,-80);
	 bottom_bolts(-80,80);
	 bottom_bolts(80,-80);
	 bottom_bolts(80,80);
         }
   
   difference(){
       translate([0,0,-10]) cylinder(r=bodysize,h=10);
       translate([0,0,-10.1]) cylinder(r=bodysize-5,h=10.1);
       }
   difference(){
       translate([0,0,bodyheight]) cylinder(r=bodysize-5,h=10);
       translate([0,0,bodyheight - .1]) cylinder(r=bodysize-5-5,h=10.2);
       layer_bolts(45);
       layer_bolts(45+90);
       layer_bolts(45+180);
       layer_bolts(45+270);
       }

}

module enclosure()
{
	%rotate([0,180,0]) translate([-44,-1,-90]) psu_base();
	difference(){
	  bodyring();
	  translate([-40,0,-10.1]) psu_frame_cutout();
	}
	translate([-40,0,-10]) psu_frame();
}   

	enclosure();
    
    

//translate([0,0,+100]) cutraidus();
