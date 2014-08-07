use<..\bearings.scad>

motor_dia_max = 38;
motor_dia_min = 36;
squeezage = 0.1;

$fn=60;
//drive_end_clamp();

//translate([0,0,30])
//small_end_clamp();

//translate([0,0,30])
dremel_end_clamp();


//spindle();

//ball_bearing(5,11,5);

//translate([0,0,30])
//ball_bearing(5,11,5);

module spindle()
{
	color("silver")
	difference()
	{
		union()
		{
			cylinder(100,2.5,2.5,false);
		}
	}
}

module module_name ()
{
	difference()
	{
		union()
		{
		
		}
	}
}

module drive_end_clamp()
{
	color("red")
	difference()
	{
		union()
		{
			cylinder(10,motor_dia_max/2+5,motor_dia_max/2+5,false);
			linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
				polygon([[0,-20],
				[-30,-30],
				[-30,-20],
				[-20,-10],
				[-10,-10],
				[-30,20],
				
				[-30,motor_dia_max/2+12],
				[7,motor_dia_max/2+12],
				[7,10]]);
			
			translate([-30,motor_dia_max/2+2,0])
			cube([4,10,20],false);
			translate([-30,-motor_dia_max/2-12,0])
			cube([4,10,20],false);
		}
		translate([0,0,-1])
		cylinder(20,motor_dia_max/2,motor_dia_max/2,false);
		
		translate([0,0,-1])
		cube([3,35,12],false);
		
		translate([1,motor_dia_max/2+8,5])
		rotate([0,90,0])
		cylinder(20,2,2,false);
		
		translate([-19,motor_dia_max/2+8,5])
		rotate([0,90,0])
		cylinder(20,1.6,1.6,false);

		translate([-31,motor_dia_max/2+7,15])
		rotate([0,90,0])
		cylinder(20,1.5,1.5,false);

		translate([-31,-motor_dia_max/2-7,15])
		rotate([0,90,0])
		cylinder(20,1.5,1.5,false);

		
	}
}

module small_end_clamp()
{
	color("red")
	difference()
	{
		union()
		{
			cylinder(10,motor_dia_min/2+5,motor_dia_min/2+5,false);
			linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
				polygon([[0,-20],
				[-30,-30],
				[-30,-20],
				[-20,-10],
				[-10,-10],
				[-30,20],
				
				[-30,motor_dia_max/2+12],
				[7,motor_dia_max/2+12],
				[7,10]]);
			
			translate([-30,motor_dia_max/2+2,0])
			cube([4,10,20],false);
			translate([-30,-motor_dia_max/2-12,0])
			cube([4,10,20],false);
		}
		translate([0,0,-1])
		cylinder(20,motor_dia_min/2+squeezage,motor_dia_min/2+squeezage,false);
		
		translate([0,0,-1])
		cube([3,35,12],false);
		
		translate([1,motor_dia_max/2+8,5])
		rotate([0,90,0])
		cylinder(20,2,2,false);
		
		translate([-19,motor_dia_max/2+8,5])
		rotate([0,90,0])
		cylinder(20,1.6,1.6,false);

		translate([-31,motor_dia_max/2+7,15])
		rotate([0,90,0])
		cylinder(20,1.5,1.5,false);

		translate([-31,-motor_dia_max/2-7,15])
		rotate([0,90,0])
		cylinder(20,1.5,1.5,false);

		
	}
}

dremel_dia_small = 24.5;

module dremel_end_clamp()
{
	color("lightblue")
	difference()
	{
		union()
		{
			cylinder(10,dremel_dia_small/2+5,dremel_dia_small/2+5,false);
			linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
				polygon([[0,-20],
				[-30,-30],
				[-30,-20],
				[-20,-10],
				[-10,0],
				[-30,20],
				
				[-30,dremel_dia_small/2+12],
				[7,dremel_dia_small/2+12],
				[7,10]]);
			
			translate([-30,dremel_dia_small/2+2,0])
			cube([6,10,20],false);
			translate([-30,-dremel_dia_small/2-12,0])
			cube([6,10,20],false);
		}
		translate([0,0,-1])
		cylinder(20,dremel_dia_small/2+squeezage,dremel_dia_small/2+squeezage,false);
		
		translate([0,0,-1])
		cube([3,35,12],false);
		
		translate([1,dremel_dia_small/2+8,5])
		rotate([0,90,0])
		cylinder(20,2,2,false);
		
		translate([-19,dremel_dia_small/2+8,5])
		rotate([0,90,0])
		cylinder(20,1.6,1.6,false);

		translate([-31,dremel_dia_small/2+7,15])
		rotate([0,90,0])
		cylinder(20,1.5,1.5,false);

		translate([-31,-dremel_dia_small/2-7,15])
		rotate([0,90,0])
		cylinder(20,1.5,1.5,false);

		
	}
}