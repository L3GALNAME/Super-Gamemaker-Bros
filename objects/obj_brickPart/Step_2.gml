/// @description Movement
frame = animSpeed * ((global.time[0][0] - global.time[2][2]) / 10);
switch floor(frame%4) {
	case 0:
		image_xscale = 1; image_yscale = 1;
	break;
	case 1:
		image_xscale = -1; image_yscale = 1;
	break;
	case 2:
		image_xscale = 1; image_yscale = -1;
	break;
	case 3:
		image_xscale = -1; image_yscale = -1;
	break;
}

x += sxReal;
y += syReal;

syReal += 0.25
if (syReal > fallCap) { syReal = fallCap; }

if (y > room_height+16) { instance_destroy(); }