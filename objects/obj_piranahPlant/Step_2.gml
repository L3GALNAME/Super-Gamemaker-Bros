/// @description Movement
if !state {
	syReal += 0.5;
	x += sxReal;
	y += syReal;
	if (syReal > fallCap) { syReal = fallCap; }
	if ((y > room_height+16) or (x < obj_camera.x - 64)) { instance_destroy(); }
}

switch floor(timer/48) {
	case 4:
		if (instance_exists(obj_player) and abs(x - obj_player.x) > 27) {
			y = origY;
			timer = 0;
		} else {
			timer = 4*48
		}
	break;
	case 0:
		y -= 0.5;
	break;
	case 2:
		y += 0.5;
	break;
}