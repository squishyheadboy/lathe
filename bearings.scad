module default_bearing(){
	ball_bearing(bearing_id,bearing_od,bearing_thickness);
}

module ball_bearing(id,od,width)
{
	height=(od-id)/2;
	union()
	{
		color("Silver") 
		difference()
		{
			cylinder(h=width,r=od/2,center=true);
			cylinder(h=width+0.1,r=od/2-height*0.2,center=true);
		}
		color("DimGray") 
		difference()
		{
			cylinder(h=width*0.9,r=od/2-height*0.2,center=true);
			cylinder(h=width+0.2,r=od/2-height*0.8,center=true);
		}
		color("Silver")
		difference()
		{
			cylinder(h=width,r=od/2-height*0.8,center=true);
 			cylinder(h=width+0.3,r=id/2,center=true);
		}
	}
}