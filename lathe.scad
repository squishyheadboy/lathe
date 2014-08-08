// 3D printable lathe, By Peter Robinson
// http://www.robinsonia.com/wp


use <bearings.scad>;
use <pulleys.scad>;
use <lathe_gears.scad>;
use <screws.scad>;
include <../MCAD/involute_gears.scad>

guide_rad=2.5;
guide_padding=3;
m4_tap=3.2;

// x direction is spindle axis
// y direction is in/out towards the centre of the workpiece
// z direction is up/down

x_car_len=40;
x_guide_sep=40;
x_guide_len=80;
x_travel_len=200;  // the length of the lathe bed over which the tooh head can move

y_guide_sep=30;
y_car_len=y_guide_sep+2*(guide_padding+guide_rad);  // lenght of y carriage along x axis
y_car_depth = x_guide_sep + 2*(guide_padding+guide_rad);
y_guide_len=80;

frame_thick=10;
guide_bush=5;
bearing_od=11;
bearing_id=5;
squeezage=0.1;
spindle_z=40;
spindle_y=-x_guide_sep/2;

pulley_radius=10;
hub_length=10;
pulley_length=10;
bed_y = 80;
frame_separation=12; // Distance between frame supports at motor end
bed_length = x_travel_len + 3*frame_thick + frame_separation;

// hole locations for frame supports
x_support_positions = [frame_thick/2,(frame_thick/2+frame_thick+frame_separation),(bed_length-frame_thick/2)];
y_support_positions = [frame_thick/2,bed_y-frame_thick/2];
bed_thick=15;


assembly();

$fn=18;

module assembly()
{

/*
translate([0,0,guide_rad+guide_padding]) x_carriage();
//translate([0,0,guide_rad+guide_padding]) x_guides();

translate([30,0,guide_rad+guide_padding]) spindle();

translate([63,spindle_y,spindle_z])
translate([0,0,guide_rad+guide_padding])
rotate([0,90,0])
ball_bearing(5,11,5);

translate([42,spindle_y,spindle_z])
translate([0,0,guide_rad+guide_padding])
rotate([0,90,0])
ball_bearing(5,11,5);

translate([0,spindle_y,spindle_z])
translate([0,0,guide_rad+guide_padding])
rotate([0,90,0])
pulley3();

translate([0,10,3*(guide_rad+guide_padding)]) y_carriage();

translate([15,10,guide_rad+guide_padding]) lathe_tool();
*/


//translate([0,50,10]) rotate([90,0,180]) control_wheel_2();
//translate([-10,100,10]) rotate([90,0,0]) control_wheel_handle();
//translate([-70,20,4]) rotate([-90,0,0]) x_drive_support();
//translate([-70,50,4]) rotate([90,0,180]) control_wheel_2();
//translate([-80,100,4]) rotate([90,0,0]) control_wheel_handle();
//translate([-70,15,5]) rotate([90,0,0]) scale([1,1,1]) gear();
//translate([-45,0,5]) rotate([0,-90,0]) scale([1,1,1]) gear();

translate([0,0,0]) scale([-1,1,1]) bed_support();
translate([0,bed_y-frame_thick,0]) scale([-1,1,1]) bed_support();

translate([0,0,bed_thick]) frame_upright();
translate([-x_support_positions[1]+frame_thick/2,0,bed_thick]) frame_upright();
translate([-x_support_positions[2]+frame_thick/2,0,bed_thick]) frame_end();


translate([61,33,5]) rotate([180,0,0]) screw_M4(10);

// x lead screw (rotates to drive tool head along spindle axis)
x_lead_z = bed_thick+frame_thick;
translate([10,bed_y/2,x_lead_z]) threaded_rod(5,bed_length+25);
translate([0,bed_y/2,x_lead_z]) rotate([0,90,0]) washer_M5(10);
translate([1,bed_y/2,x_lead_z]) rotate([0,90,0]) nut_M5(10);
translate([6,bed_y/2,x_lead_z]) rotate([0,90,0]) rotate([0,0,30]) nut_M5(10); // lock nut

translate([-bed_length,bed_y/2,x_lead_z]) rotate([0,-90,0]) washer_M5(10);
translate([-bed_length-1,bed_y/2,x_lead_z]) rotate([0,-90,0]) nut_M5(10);
//translate([-bed_length-6, bed_y/2, x_lead_z]) rotate([0,-90,0]) scale([1,1,1]) gear();
translate([-bed_length-8,bed_y/2,x_lead_z]) rotate([0,-90,0]) nut_M5(10);


// x back support screwed rod (no rotation, just structural)
x_support_z = bed_thick+frame_thick+20;
translate([6,bed_y/2-x_guide_sep/2,x_support_z]) threaded_rod(5,bed_length+12);  // threaded rod

for(xpos=[0,-bed_length+frame_thick]) // nuts and washers at both ends of screwed rod
{
	translate([xpos,0,0])
	{
		translate([0,bed_y/2-x_guide_sep/2,x_support_z]) rotate([0,90,0]) washer_M5(10);
		translate([1,bed_y/2-x_guide_sep/2,x_support_z]) rotate([0,90,0]) nut_M5(10);
		translate([-frame_thick,bed_y/2-x_guide_sep/2,x_support_z]) rotate([0,-90,0]) washer_M5(10);
		translate([-frame_thick-1,bed_y/2-x_guide_sep/2,x_support_z]) rotate([0,-90,0]) rotate([0,0,30]) nut_M5(10);
	}
}

// x slide guide rods
x_guide_len = bed_length - frame_thick-frame_separation;
color("lightgray") translate([-(frame_thick+frame_separation),0,x_lead_z]) rotate([0,-90,0])
union()
{
	translate([0,bed_y/2-x_guide_sep/2,0]) cylinder(x_guide_len,guide_rad,guide_rad,false);
	translate([0,bed_y/2+x_guide_sep/2,0]) cylinder(x_guide_len,guide_rad,guide_rad,false);
}

translate([-bed_length/2,bed_y/2,x_lead_z]) x_carriage();
// y slide guide rods
color("lightgray") translate([-(bed_length/2), bed_y/2-x_guide_sep/2 ,x_lead_z+2*(guide_rad+guide_padding)]) rotate([-90,0,0])
union()
{
	translate([-y_guide_sep/2,0,0]) cylinder(y_car_depth,guide_rad,guide_rad,false);
	translate([y_guide_sep/2,0,0]) cylinder(y_car_depth,guide_rad,guide_rad,false);
}

translate([-bed_length/2,bed_y/2+10,x_lead_z+2*(guide_rad+guide_padding)]) y_carriage();




translate([46,spindle_y,spindle_z+6]) rotate([0,90,0]) collet();

}


xs_len=20;
xs_height=25;
xs_angle=12;
xs_base = xs_height*tan(xs_angle)+30;
module x_drive_support ()
{
	difference()
	{
		union()
		{
			cylinder(xs_len,5,5,false);
			rotate([0,0,-xs_angle])
			
			cube([4, xs_height/cos(xs_angle),xs_len],false);
			rotate([0,0,xs_angle])
			translate([-4,0,0])
			cube([4,xs_height/cos(xs_angle),xs_len],false);
			
			translate([-xs_base/2,xs_height-5,0])
			cube([xs_base,5,xs_len],false);
		}
		translate([0,0,-1])
		cylinder(xs_len+2,2.5,2.5,false);
		
		translate([13,xs_height,10])
		rotate([90,0,0])
		union()
		{
			translate([0,0,4.1])
			cylinder(2,2,4,true);
			cylinder(12,2,2,true);
		}
		translate([-13,xs_height,10])
		rotate([90,0,0])
		union()
		{
			translate([0,0,4.1])
			cylinder(2,2,4,true);
			cylinder(12,2,2,true);
		}


		}
}


module threaded_rod(msize,length)
{
	rotate([0,-90,0]) 
	color("darkgrey")
		cylinder(length,msize/2,msize/2,false);
}



cutout_rad=10;
module bed_support ()
{
	color("royalblue")
	difference()
	{
		union()
		{
			cube([bed_length,frame_thick,bed_thick+2],false);
		}
		
		translate([0,0,2])
		hull()
		{
			translate([3*frame_thick+frame_separation+cutout_rad,-1,bed_thick]) rotate([-90,0,0]) cylinder(12,cutout_rad,cutout_rad,false);
			translate([bed_length-2*frame_thick-cutout_rad,-1,bed_thick]) rotate([-90,0,0]) cylinder(12,cutout_rad,cutout_rad,false);
		}

		for (i=[0,1,2])
		{
			echo(x_support_positions[i]);
			// Vertical support mounting slots
			translate([x_support_positions[i],frame_thick/2,bed_thick+1.5]) cube([frame_thick+2*squeezage,frame_thick+2,3],true);
			// Mounting holes
			translate([x_support_positions[i],frame_thick/2,-1]) cylinder(bed_thick+5,2,2,false);
		}
	}
}

module collet_small()
{
	difference()
	{
		union()
		{
			cylinder(2,4.5,4.5,false);
			translate([0,0,2])
			cylinder(2,4.5,3.5,false);
		}
		translate([0,0,-1])
		cylinder(15,2.5+squeezage,2.5+squeezage,false);


	}
}


module collet ()
{
	difference()
	{
		union()
		{
			cylinder(7,8,8,false);
			translate([0,0,7])
			cylinder(1,4.5,4.5,false);
			translate([0,0,8])
			cylinder(2,4.5,3.5,false);
		}
		translate([0,0,-1])
		cylinder(15,2.5+squeezage,2.5+squeezage,false);

		translate([0,0,4])
		rotate([90,0,0])
		cylinder(20,1.6,1.6,true);
	}
}
module hexagon_af(af,len)
{
	od = af/cos(30);
	difference()
	{
		union()
		{
		linear_extrude(height=len,center=true,convexity=10,twist=0,$fn=12)
			polygon(points = [[0,od/2],[af/2,od/4],[af/2,-od/4],[0,-od/2],[-af/2,-od/4],[-af/2,od/4],[0,od/2]]);
		}
	}
}


module control_wheel_handle()
{
	difference()
	{
		union()
		{
			cylinder(12,4,4,false);
			translate([0,0,12])
			cylinder(12,2.5,2.5,false);
			translate([0,0,24])
			cylinder(4,3.5,2.5,false);
			
		}
			translate([0,0,24])
			cube([1,10,10],true);
		
	}
}

module control_wheel_2 ()
{
	difference()
	{
		union()
		{
			rotate_extrude()
			polygon(points=[[0,0],[8,0],[8,4],[16,12],[16,16],[12,16],[12,12],[8,8],[0,8],[0,0]]);
			
			translate([11,0,0])
			cylinder(16,5,5,false);
		}
		translate([0,0,-1])
		cylinder(16,2.5,2.5,false);
		
		translate([0,0,13])
		hexagon_af(8+2*squeezage,20);		
		
		translate([11,0,-1])
		cylinder(18,2.5,2.5,false);

		translate([11,0,-1])
		cylinder(5,3.5,3.5,false);
		
	}
}

module control_wheel ()
{
	difference()
	{
		union()
		{
			cylinder(6,8,8,false);
			
			translate([0,0,6])
			cylinder(10,8,15,false);
			
			translate([0,0,16])
			cylinder(6,15,15,false);
		}
		translate([0,0,6])
		cylinder(10,5,12,false);

		translate([0,0,15])
		cylinder(10,12,12,false);

		translate([0,0,-1])
		cylinder(50,2.5,2.5,false);
		
		translate([0,0,13])
		hexagon_af(8+2*squeezage,20);
	}
}

module lathe_tool ()
{
	translate([0,0,spindle_z])
	rotate([90,0,0])
	difference()
	{
		union()
		{
			cylinder(30,2.5,2.5,true);
		}
		translate([0,2.5,15])
		rotate([0,90,0])
		cylinder(30,2.5,2.5,true);
	}
}


module spindle()
{
	color("silver")
	difference()
	{
		union()
		{
		translate([20,spindle_y,spindle_z])
		rotate([0,90,0])
		cylinder(x_guide_len+30,guide_rad,guide_rad,true);
		}
	}
}


module x_guides()
{
	color("silver")
	difference()
	{
		union()
		{
		rotate([0,90,0])
		cylinder(x_guide_len,guide_rad,guide_rad,true);
		translate([0,x_guide_sep/2,0])
		rotate([0,90,0])
		cylinder(x_guide_len,guide_rad,guide_rad,true);
		translate([0,-x_guide_sep/2,0])
		rotate([0,90,0])
		cylinder(x_guide_len,guide_rad,guide_rad,true);
		}
	}
}

module x_carriage()
{
	$fn=30;
	color("red")
	difference()
	{
		union()
		{
			cube([x_car_len,x_guide_sep+10,2*(guide_rad+guide_padding)],true);
			
			translate([0,(x_guide_sep+10)/2-5+10,1*(guide_rad+guide_padding)])
			cube([x_car_len,10,4*(guide_rad+guide_padding)],true);
			
			translate([0,-(x_guide_sep+10)/2+5,2*(guide_rad+guide_padding)])
			cube([x_car_len,10,2*(guide_rad+guide_padding)],true);
			
		}
		
		rotate([0,90,0])
		cylinder(x_car_len+2,guide_rad,guide_rad,true);
		translate([0,x_guide_sep/2,0])
		rotate([0,90,0])
		cylinder(x_car_len+2,guide_rad,guide_rad,true);
		translate([0,-x_guide_sep/2,0])
		rotate([0,90,0])
		cylinder(x_car_len+2,guide_rad,guide_rad,true);
		
		translate([0,0,2*(guide_rad+guide_padding)])
		rotate([90,0,0])
		cylinder(x_guide_sep+30+2,guide_rad,guide_rad,true);
		
		translate([y_guide_sep/2,0,2*(guide_rad+guide_padding)])
		rotate([90,0,0])
		cylinder(x_guide_sep+30+2,guide_rad,guide_rad,true);
		
		translate([-y_guide_sep/2,0,2*(guide_rad+guide_padding)])
		rotate([90,0,0])
		cylinder(x_guide_sep+30+2,guide_rad,guide_rad,true);
		
		
		translate([x_car_len/2-10,0,0])
		cube([5,8,20],true);
		translate([-x_car_len/2+10,0,0])
		cube([5,8,20],true);
	}
}

module y_carriage()
{
	$fn=30;
	color("silver")
	difference()
	{
	
		translate([0,0,0.2])
		union()
		{
			translate([0,0,0.2])
			cube([y_car_len,20,2*(guide_rad+guide_padding)],true);

			translate([y_car_len/2-8,0,guide_rad+guide_padding+30/2])
			cube([16,20,30],true);

			
		}
		translate([y_guide_sep/2,0,spindle_z-2*(guide_rad+guide_padding)]) rotate([90,0,0]) cylinder(x_car_len+2,guide_rad,guide_rad,true);
		translate([y_guide_sep/2,0,spindle_z-2*(guide_rad+guide_padding)]) rotate([0,90,0]) cylinder(x_car_len+2,m4_tap/2,m4_tap/2,true);
		
		rotate([90,0,0])
		cylinder(x_car_len+2,guide_rad,guide_rad,true);
		translate([y_guide_sep/2,0,0])
		rotate([90,0,0])
		cylinder(x_car_len+2,guide_rad,guide_rad,true);
		translate([-y_guide_sep/2,0,0])
		rotate([90,0,0])
		cylinder(x_car_len+2,guide_rad,guide_rad,true);
		
		translate([0,0,0])
		cube([8,4,20],true);
	}
}



module strut(x1,y1,x2,y2,width,thickness)
{
	len=sqrt((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2));
	angle=atan2(y2-y1,x2-x1);
	
	translate([0,x1,y1])
	rotate([angle,0,0])
	translate([0,len/2,0])
	cube([thickness,len,width],true);
}

module frame_upright()
{
	$fn=24;
	translate([-frame_thick/2,bed_y/2,frame_thick])
	difference()
	{
		union()
		{
		
			strut(spindle_y,spindle_z,-x_guide_sep/2,0,10,10);
			strut(-x_guide_sep/2,0,x_guide_sep/2,0,10,10);
			strut(spindle_y,spindle_z,x_guide_sep/2,0,10,10);
			
			translate([0,0,-5])	cube([frame_thick,80,10],true);
		
			translate([0,0,0]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);
			translate([0,x_guide_sep/2,0]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);
			translate([0,-x_guide_sep/2,0]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);

			translate([0,-x_guide_sep/2,spindle_z/2]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);
			
			// spindle hole
			translate([0,spindle_y,spindle_z]) rotate([0,90,0]) cylinder(frame_thick,bearing_od/2+guide_bush,bearing_od/2+guide_bush,true);
		}
		
		translate([0,0,0])  rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		translate([0,x_guide_sep/2,0])  rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		translate([0,-x_guide_sep/2,0]) rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		
		translate([0,-x_guide_sep/2,spindle_z/2]) rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		
		// spindle hole
		translate([2,spindle_y,spindle_z]) rotate([0,90,0]) cylinder(frame_thick-2,bearing_od/2+squeezage,bearing_od/2+squeezage,true);
		translate([0,spindle_y,spindle_z]) rotate([0,90,0]) cylinder(frame_thick+2,bearing_id/2+1.5,bearing_id/2+1.5,true);
		
		// mounting holes
		translate([0,34,0]) cylinder(frame_thick*2+1,2,2,true);
		translate([0,-34,0]) cylinder(frame_thick*2+1,2,2,true);
		
		
	}
}

module frame_end()
{
	$fn=30;
	translate([-frame_thick/2,bed_y/2,frame_thick])
	difference()
	{
		union()
		{
		
			strut(spindle_y,spindle_z/2,-x_guide_sep/2,0,10,10);
			strut(-x_guide_sep/2,0,x_guide_sep/2,0,10,10);
			strut(spindle_y,spindle_z/2,x_guide_sep/2,0,10,10);
			
			translate([0,0,-5])	cube([frame_thick,80,10],true);
		
			translate([0,0,0]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);
			translate([0,x_guide_sep/2,0]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);
			translate([0,-x_guide_sep/2,0]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);

			translate([0,-x_guide_sep/2,spindle_z/2]) rotate([0,90,0]) cylinder(frame_thick,guide_rad+guide_bush,guide_rad+guide_bush,true);
			
		}
		
		translate([0,0,0])  rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		translate([0,x_guide_sep/2,0])  rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		translate([0,-x_guide_sep/2,0]) rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
		
		translate([0,-x_guide_sep/2,spindle_z/2]) rotate([0,90,0]) cylinder(frame_thick+1,guide_rad,guide_rad,true);
	
		
		// mounting holes
		translate([0,34,0]) cylinder(frame_thick*2+1,2,2,true);
		translate([0,-34,0]) cylinder(frame_thick*2+1,2,2,true);
		
		
	}
}

module gear()
{

	difference()
	{
		//cylinder(10,7,7,false);
		//translate([0,0,-1])
		//cylinder(16,2.5+squeezage,2.5+squeezage,false);

		bevel_gear (
			number_of_teeth=9,
			cone_distance=28.28,
			//cone_distance=20,
			face_width=8,
			outside_circular_pitch=600,
			pressure_angle=30,
			clearance = 0.2,
			bore_diameter=5+2*squeezage,
			gear_thickness = 30,
			backlash = 0,
			involute_facets=0,
			finish = -1);
			
			translate([0,0,8])
			hexagon_af(8,10);
			
	}
}

