$fn=60;

pulley_radius=10;
pulley_length=8;
hub_radius=6;
hub_length=15;
shaft_radius=2.5;
shaft_flat=1;
bearing_id=6;
bearing_od=12;
bearing_length=4;
squeezage=0.1;

translate([0,0,0]) idler(10,10);
translate([50,0,0]) pulley();
translate([50,50,0]) pulley2();
translate([0,50,0]) pulley3();

module idler(idler_radius,idler_length)
{
	translate([0,0,idler_length/2])

	difference()
	{
		union()
		{
			translate([0,0,-idler_length/2+1])
				cylinder(2,idler_radius+2,idler_radius,center=true);
			translate([0,0,idler_length/2-1])
				cylinder(2,idler_radius,idler_radius+2,center=true);
			cylinder(idler_length,idler_radius,idler_radius,center=true);
		}
		cylinder(idler_length+2,bearing_od/2-1,bearing_od/2-1,center=true);
		translate([0,0,2])
		cylinder(bearing_thickness+2,bearing_od/2+squeezage,bearing_od/2+squeezage,center=true);
	}

	default_bearing();
	//translate([0,0,-10])
	//screw_M4(16);
}

module hub()
{
	difference()
	{
		union()
		{
			difference()
			{
				cylinder(hub_length,hub_radius,hub_radius,center=true);
				cylinder(hub_length+1,shaft_radius+squeezage,shaft_radius+squeezage,center=true);
			}
			// flat on internal diameter
			translate([shaft_radius-shaft_flat+squeezage,-3,-hub_length/2])
			cube([shaft_flat,6,hub_length],false);
		}
		// grub screw hole
		translate([hub_radius/2,0,(hub_length - pulley_length)/2])
		rotate([0,90,0])
			cylinder(hub_radius,1.5,1.5,center=true);
	}
}

module pulley()
{
	translate([0,0,pulley_length/2])
	union()
	{
		translate([0,0,hub_length/2-pulley_length/2])
			hub();

		for(angle=[0:60:300])
		{
			rotate([0,0,angle])
			translate([-1,2.5,-pulley_length/2])
			cube([2,6,pulley_length],false);
		}

	difference()
	{
		union()
		{
			translate([0,0,-pulley_length/2+1])
				cylinder(2,pulley_radius+2,pulley_radius,center=true);
			translate([0,0,pulley_length/2-1])
				cylinder(2,pulley_radius,pulley_radius+2,center=true);
			cylinder(pulley_length,pulley_radius,pulley_radius,center=true);
		}
		cylinder(pulley_length+6,pulley_radius-2,pulley_radius-2,center=true);
	}
	}
}

module pulley3 ()
{
	translate([0,0,1])
	difference()
	{
		union()
		{
			translate([0,0,-1])
			cylinder(1,pulley_radius,pulley_radius+1,center=false);

			cylinder(hub_length,hub_radius,hub_radius,center=false);
			cylinder(pulley_length,pulley_radius,pulley_radius,center=false);
			translate([0,0,0])
			cylinder(1,pulley_radius+1,pulley_radius+1,center=false);
			translate([0,0,1])
			cylinder(1,pulley_radius+1,pulley_radius,center=false);
			translate([0,0,pulley_length-2])
			cylinder(1,pulley_radius,pulley_radius+1,center=false);
			translate([0,0,pulley_length-1])
			cylinder(1,pulley_radius+1,pulley_radius+1,center=false);
		}
		translate([0,0,-2])
		cylinder(hub_length+4,shaft_radius+squeezage,shaft_radius+squeezage,center=false);
		
		// grub screw hole
		translate([0,0,hub_length - pulley_length/2])
		rotate([0,90,0])
			cylinder(hub_radius*3,1.5,1.5,center=true);
		
		
	}
}

module pulley2()
{
	difference()
	{
		union()
		{
			difference()
			{
				union()
				{
					// main load cylinder
					cylinder(hub_length,hub_radius,hub_radius,false);
					// tapered ends
					cylinder(2,pulley_radius+2,pulley_radius,false);
					translate([0,0,pulley_length-1]) cylinder(2,pulley_radius,pulley_radius+2,center=true);
					// hub
					cylinder(pulley_length,pulley_radius,pulley_radius,false);
				}

				// hole for shaft
				translate([0,0,-1]) cylinder(hub_length+2,shaft_radius+squeezage,shaft_radius+squeezage,false);
			}
			// flat on internal diameter
			translate([shaft_radius-shaft_flat+squeezage,-3,0]) cube([shaft_flat,6,hub_length],false);
		}
		// grub screw hole
		translate([hub_radius/2,0,pulley_length+(hub_length - pulley_length)/2]) rotate([0,90,0]) cylinder(hub_radius,1.5,1.5,center=true);
	}
}


