

module psu_body()
{ 
	cube([140,150,86.0]);


}

module psu_cuts()
{
   translate([5,5,5]) cube([130,140,76]);


}


module psu()
{

	difference(){
          psu_body();
          psu_cuts();
          }

}


psu();