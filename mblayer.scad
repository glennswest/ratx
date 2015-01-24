
include <puzzlecutlib/puzzlecutlib.scad>
use <MCAD/nuts_and_bolts.scad>;
use <cgrid.scad>;
use <bodyring.scad>;

$fn=500;
bodysize=133;
insidebody=bodysize-5;
bodyheight=30;

stampSize = [500,500,200];		//size of cutting stamp (should cover 1/2 of object)

cutSize = 4;	//size of the puzzle cuts

xCut1 = [-64, -8, 8, 27, 45, 64];	//locations of puzzle cuts relative to X axis center
yCut1 = [-64, -8, 8, 64];				//for Y axis

kerf = 0;		//supports +/- numbers (greater value = tighter fit)
					//using a small negative number may be useful to assure easy fit for 3d printing
					//using positive values useful for lasercutting
					//negative values can also help visualize cuts without seperating pieces


module motherboard()
{
  %import("/Users/gwest/3dprinter/ratx/motherboard.stl");
}

module pcatx_base()
{
import("mini-itx.stl", convexity=3);
}



module cutraidus(h)
{
	difference(){
             cylinder(r=insidebody,h=h);
             translate([insidebody,-insidebody+50+60,-.2]) rotate([0,0,90]) cube([insidebody*2,insidebody*2,h+.4]);
             }

}




module screw_body(height)
{
   difference(){
      cylinder(r=5,h=height);
      boltHole(3,length=height+2);
      }
}

module screw_stalk(sx,sy,ax,ay){
 translate([sx,sy, -10.1+12.7]) screw_body(2);
 hull(){
       translate([sx,sy,-10.1]) screw_body(12.7);
       translate([ax,ay,-10]) rotate([0,0,90]) cube([5,5,4]);
       }
}

module bodylayer()
{
    translate([bodysize-18,-18,0]) cube([10,36,10]);
    translate([-bodysize+10,-18,0]) cube([10,36,10]);
    bodyring();
    difference(){
         translate([0,0,-10]) cylinder(r=bodysize-12,h=12);
         translate([0,0,-10.1]) cutraidus(h=bodyheight+12.1);
         translate([0,0,-10.1]) rotate([0,0,180]) cutraidus(h=bodyheight+12.1);
         }
  
     screw_stalk(-80,-51,-78,-22);
     screw_stalk(-80,81,-78,18);
     screw_stalk(80,80,80,18);
     screw_stalk(80,-80,80,-22);
   
}

module enclosure()
{
	
	bodylayer();
	//translate([0,0,2]) pcatx_base();
	translate([13,46,4]) rotate([0,180,180]) motherboard();
}

	enclosure();
    
    