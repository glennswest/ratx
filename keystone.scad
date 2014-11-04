
module keystone()
{
     rotate([0,0,90]) {
			difference(){
				translate([0,0,.1]) cube([23,30.5,9.8]);
					translate([4,4,0]){
						difference(){
							cube([15,23.5,10]);
							translate([-1,-.501,3.501]) cube([17,2,6.5]);  // add .501
							translate([-1,2.5,-3.40970]) rotate([45,0,0]) cube([17,2,6.5]);
							translate([-1,18.501,6.001]) cube([17,5,4]);
							translate([-1,21.5,0]) rotate([-45,0,0]) cube([17,2,6.5]);
						}
					}
				}
			}
}

keystone();