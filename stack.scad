

translate([0,0,0]) import("mbparta.stl", convexity=3);
rotate([0,0,90]) translate([0,0,60]) import("mbpartb.stl", convexity=3);
rotate([0,0,-90]) translate([0,0,120]) import("mbpartc.stl", convexity=3);
rotate([0,0,-180]) translate([0,0,180]) import("mbpartd.stl", convexity=3);