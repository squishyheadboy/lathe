
function main()
{
	return ball_bearing(5,13,5);
}

function ball_bearing(id, od, width)
{
	var height=(od-id)/2;
	var parts = Array();
	parts.push(CSG.cylinder({start:[0,0,-width/2],end:[0,0,width/2],radius:od/2})
			.subtract(CSG.cylinder({start:[0,0,-width/2-1],end:[0,0,width/2+1],radius:od/2-height*0.2}))
			.setColor([0.8,0.8,0.8]));

		parts.push(CSG.cylinder({start:[0,0,-width*0.9/2],end:[0,0,width*0.9/2],radius:od/2-height*0.2})
			.subtract(CSG.cylinder({start:[0,0,-width/2-1],end:[0,0,width/2+1],radius:od/2-height*0.8}))
			.setColor([0.5,0.5,0.5]));
	
		parts.push(CSG.cylinder({start:[0,0,-width/2],end:[0,0,width/2],radius:od/2-height*0.8})
			.subtract(CSG.cylinder({start:[0,0,-width/2-1],end:[0,0,width/2+1],radius:id/2}))
			.setColor([0.8,0.8,0.8]));
	return parts;
}