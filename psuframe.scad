use <MCAD/nuts_and_bolts.scad>;

module psu_base()
{
import("psu.stl", convexity=3);
	
}

module psu_bolts(px,py)
{
    //rotate([0,0,angle]) translate([0,bodysize,-5]) rotate([0,0,0]) boltHole(4,length=15);
    %translate([px,py,1]) rotate([0,0,0]) boltHole(3,length=15);
    translate([px,py,1]) rotate([0,0,0]) boltHole(3,length=15);
    //translate([px,py,0]) rotate([0,0,0]) nutHole(5,length=15);
}


module psu_frame_cutout()
{
	translate([105,100,0]) rotate([0,0,180]) cube([120,200,100]);	
}


module psu_frame()
{
		difference(){			
		  translate([105,100,0]) rotate([0,0,180]) cube([120,200,10]);
	          translate([85-(88-73)/2,75-(152-127)/2,-0.1]) rotate([0,0,180])  cube([73,127,5.1]);
	          translate([85,75,5])    rotate([0,0,180])  cube([88,152,5.1]);
		  psu_bolts(6,69);
	          psu_bolts(6+64,69);
                  psu_bolts(6,69-138);
                  
                  
                  //psu_bolts(6+64,69-114);	
		  }
	
}


module psu()
{
		%translate([0,0,90]) rotate([180,0,0]) psu_base();
	        
	        translate([1.5,0,0]) psu_frame();
	
}


psu();