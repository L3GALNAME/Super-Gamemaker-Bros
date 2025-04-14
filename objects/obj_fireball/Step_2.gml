/// @description Movement
if (state == "boom") {
	frame += animSpeed;
	if (frame >= 3) { instance_destroy(); }
	exit;
}

frame = animSpeed * ((global.time[0][0] - global.time[2][2]) / 10);
switch floor(frame%4) {
	case 0:
		xscale = 1; yscale = 1;
	break;
	case 1:
		xscale = -1; yscale = 1;
	break;
	case 2:
		xscale = 1; yscale = -1;
	break;
	case 3:
		xscale = -1; yscale = -1;
	break;
}

var fall = syReal>-1;
sxReal = moveX(sxReal, obj_fireball);
syReal = moveY(syReal, fall, true, self);
if (syReal > fallCap) { syReal = fallCap; }

sprite_index = spr_explosion; // Bigger hitbox
var enemy = instance_place(x, y, obj_enemy);
if (enemy and enemy.action != "flip") {
	if enemy.hitable[1] {
		// Makes sure they can be killed with fire
		with enemy {
			instance_create_layer(x, bbox_top-16, "Front", obj_scorePopup, { value : 100, syReal : -0.75 });
			y -= 16;
			syReal = -3;
			fallCap = 3;
			action = "flip";
			state = false;
		}
		audio_play_sound(sfx_kick, 50, false);
	} else {
		audio_play_sound(sfx_bump, 50, false);
	}
	state = "boom";
	frame = 0;
	animSpeed = 30/60;
}
sprite_index = spr_fireball; // Reset sprite/hitbox

if (y > room_height+16 or sxReal == 0) {
	if (sxReal == 0) { audio_play_sound(sfx_bump, 50, false); }
	state = "boom";
	frame = 0;
	animSpeed = 30/60;
}