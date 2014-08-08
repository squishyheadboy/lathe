module screw_M4(length)
{
	head_chamfer=0.5;
	screw_size = 4;
	head_radius = 0.75*screw_size;
	color("DimGray")
	union(){
		cylinder(h=length,r=2,center=false);
		translate([0,0,-(screw_size-head_chamfer)/2])
		difference() {
			union() {
				cylinder(h=screw_size-head_chamfer,r=head_radius,center=true);	
				translate([0,0,-(screw_size)/2])
					cylinder(head_chamfer,head_radius-head_chamfer/2,head_radius,center=true);	
			}
			translate([0,0,-screw_size/2])
				cylinder(h=screw_size,r=screw_size/2,center=true	,$fn=6);
		}
	}
}

module metric_bolt(screw_size, length)
{
	head_chamfer=0.5;
	head_radius = 0.75*screw_size;
	color("DimGray")
	union(){
		cylinder(h=length,r=2,center=false);
		translate([0,0,-(screw_size-head_chamfer)/2])
		difference() {
			union() {
				cylinder(h=screw_size-head_chamfer,r=head_radius,center=true);	
				translate([0,0,-(screw_size)/2])
					cylinder(head_chamfer,head_radius-head_chamfer/2,head_radius,center=true);	
			}
			translate([0,0,-screw_size/2])
				cylinder(h=screw_size,r=screw_size/2,center=true	,$fn=6);
		}
	}
}

module metric_cap_head_screw(screw_size,length){
	head_chamfer=0.5;
	head_radius = 0.75*screw_size;
	color("DimGray")
	union(){
		cylinder(h=length,r=screw_size/2,center=false);
		translate([0,0,-(screw_size-head_chamfer)/2])
		difference() {
			union() {
				cylinder(h=screw_size-head_chamfer,r=head_radius,center=true);	
				translate([0,0,-(screw_size)/2])
					cylinder(head_chamfer,head_radius-head_chamfer/2,head_radius,center=true);	
			}
			translate([0,0,-screw_size/2])
				cylinder(h=screw_size,r=screw_size/2,center=true,$fn=6);
		}
	}
}

module nut_M4(){
	metric_nut(4);
}

module nut_M2(){
	metric_nut(2);
}

module nut_M5(){
	metric_nut(5);
}

module metric_nut(screw_size){
	nut_height = 0.9*screw_size;
    color("Silver")
	difference()
	{
		intersection(){
			cylinder(nut_height,screw_size*2,screw_size*0.9,$fn=60);
			cylinder(h=nut_height,r=screw_size,center=false,$fn=6);
		}
		translate([0,0,-1])
		cylinder(nut_height+2,screw_size/2,screw_size/2,$fn=24);
	}
}

module washer_M5(){
	metric_washer(5);
}

module washer_M4(){
	metric_washer(4);
}

module washer_M2(){
	metric_washer(2);
}

module metric_washer(screw_size){
	thickness = 0.1*screw_size;
	color("darkgrey")
	difference(){
		cylinder(h=thickness,r=screw_size,center=false);
		translate([0,0,-1]) cylinder(h=thickness+2,r=screw_size/2,center=false);
	}
}
	
module screw_M5(length)
{
	color("DimGray")
	metric_cap_head_screw(5,length);
}

module screw_M3(length)
{
	color("DimGray")
	metric_cap_head_screw(3,length);
}

module screw_M2(length)
{
	color("Silver")
	metric_cap_head_screw(2,length);
}


$fn=60;
screw_M4(20);
translate([0,0,9]) washer_M4();
translate([0,0,10]) nut_M4();

translate([0,10,0]) screw_M5(20);
translate([0,10,7]) washer_M5();
translate([0,10,10])  nut_M5();
