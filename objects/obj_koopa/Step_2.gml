/// @description Application
if !state {
	if (action == "flip") {
		x += sxReal;
		y += syReal;
		if (syReal > fallCap) { syReal = fallCap; }
		if ((y > room_height+16) or (x < obj_camera.x - 64)) { instance_destroy(); }
	}
	exit;
}

// Application

var fall = syReal>-1;
sxReal = moveX(sxReal, obj_koopa);
syReal = moveY(syReal, fall, false, self);
if (syReal > fallCap) { syReal = fallCap; }
if (sxReal == 0 and action != "shell" ) {
	sxReal = preSX * -1
	if (action == "kick") { audio_play_sound(sfx_bump, 40, false); }
}

dir = abs(sxReal) / sxReal;
if (dir == 0) { dir = preD; }
dir *= -1

if ((y > room_height+16) or (x < obj_camera.x - 64)) { instance_destroy(); }