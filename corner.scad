
include <puzzlecutlib/puzzlecutlib.scad>
use <MCAD/nuts_and_bolts.scad>;
use <cgrid.scad>;

bodysize=140;
insidebody=bodysize-10;
bodyheight=50;

stampSize = [500,500,200];		//size of cutting stamp (should cover 1/2 of object)

cutSize = 4;	//size of the puzzle cuts

xCut1 = [-64, -8, 8, 27, 45, 64];	//locations of puzzle cuts relative to X axis center
yCut1 = [-64, -8, 8, 64];				//for Y axis

kerf = 0;		//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces


module mount_bolts(angle)
{
    rotate([0,0,angle]) translate([-25,bodysize-5,bodyheight/2+10]) rotate([90,0,0]) boltHole(5,length=30);
    rotate([0,0,angle]) translate([-25,bodysize-5,bodyheight/2-10]) rotate([90,0,0]) boltHole(5,length=30);

}

module layer_bolts(angle)
{
    rotate([0,0,angle]) translate([0,bodysize,bodyheight+5]) rotate([90,0,0]) boltHole(3,length=15);
}

module bottom_bolts(angle)
{
    rotate([0,0,angle]) translate([0,bodysize,-5]) rotate([90,0,0]) boltHole(4,length=15);
}


module pcatx_base()
{
import("mini-itx.stl", convexity=3);
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
         //cylinder(r=bodysize,h=2);
         translate([0,0,-10]) cgrid(bodysize,12,hs=5,sp=6);
         translate([0,0,-10.1]) cutraidus(h=bodyheight+10.1);
         translate([0,0,-10.1]) rotate([0,0,180]) cutraidus(h=bodyheight+10.1);
	 difference(){
		 translate([0,0,-10.1]) cylinder(r=bodysize-10,h=10);
		 translate([0,0,-10.1]) cylinder(r=bodysize-15,h=10);
	         }
         }
   //difference(){
   //      //cylinder(r=bodysize,h=8);
   //      translate([0,0,-10]) cgrid(bodysize-15,2,hs=5,sp=6);
   //      translate([0,0,-10.1]) cutraidus(h=bodyheight+.1);
   //      translate([0,0,-10.1]) rotate([0,0,180]) cutraidus(h=bodyheight+.1);
  //       }
   difference(){
       translate([0,0,-10]) cylinder(r=bodysize,h=10);
       translate([0,0,-10.1]) cylinder(r=bodysize-5,h=10.1);
       bottom_bolts(45);
       bottom_bolts(45+90);
       bottom_bolts(45+180);
       bottom_bolts(45+270);
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
	bodyring();
	translate([-85,-85,0]) pcatx_base();

}

	enclosure();
    
    

//translate([0,0,+100]) cutraidus();