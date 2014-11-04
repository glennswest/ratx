module cgrid_calc(gtr,ghs,gha,gsp,gra)
{
   //echo("calc: gtr=",gtr,"ghs=",ghs,"gha=",gha,"gsp=",gsp,"gra=",gra);
   gof = 0;
   gcir = 2 * gtr * 3.14;
   gct = floor(gcir / (ghs + gsp));
   gst = 360 / gct;
   //echo("ghs=",ghs,"circ=",gcir,"tr=",gtr,"Step=",gst,"Count=",gct,"hs=",ghs,"sp=",gsp);
   if (gof == 0){
             assign(gof = 2 * gha);
            } else { 
             assign(of = 0);
            }
    for(tc = [0 : gst : 360 ]){
           rotate([0,0,tc+gof]) translate([gtr,0,-.1]) cylinder(r=ghs,h=gha+.2,$fn=5);
           }

}

module cgrid(ra,ha,hs=2,sp=3)
{
   
   is = -1 * (hs + sp );
   gstart = ra - ( 2 * hs);
   //st = 360 / ct * 2;
   ep = 0;
   //echo( st );

	difference(){
      cylinder(r=ra,h=ha);
      for(tr = [ gstart : is : ep]) {
          cgrid_calc(tr,hs,ha,sp,ra);          
          }
       }
}


//cgrid(180,20,hs=5,sp=6);