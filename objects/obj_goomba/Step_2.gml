/// @description Application
if !state {
	if (action != "walk") {
		x += sxReal;
		y += syReal;
		if (syReal > fallCap) { syReal = fallCap; }
		if ((y > room_height+16) or (x < obj_camera.x - 64)) { instance_destroy(); }
	}
	exit;
}

// Application

var fall = syReal>-1;
sxReal = moveX(sxReal, obj_goomba);
syReal = moveY(syReal, fall, false, self);
if (syReal > fallCap) { syReal = fallCap; }
if (sxReal == 0) { sxReal = preSX * -1}

if ((y > room_height+16) or (x < obj_camera.x - 64)) { instance_destroy(); }