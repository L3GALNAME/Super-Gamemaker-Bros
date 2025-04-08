/// @description Movement
preSX = sxReal;
preD = dir;
if state {
	if (action == "walk") {
		var fall = syReal>-1;
	    syReal += 0.25 + (0.75 * (fall and syReal<2));
		frame = animSpeed * ((global.time[0][0] - global.time[2][2]) / 10);
		if place_meeting(x+round(sxReal), y, obj_enemy) { sxReal *= -1; }
	} else {
		var fall = syReal>-1;
	    syReal += 0.25 + (0.75 * (fall and syReal<2));
		if (sxReal == 0) {
			// GETUP
			frame += 6/60;
			
			// Kicked
			if (instance_exists(obj_player) and place_meeting(x, y, obj_player)) {
				sxReal = (obj_player.x < x ? 3.5 : -3.5);
				frame = 5;
			}
			
			if (frame > 40) {
				sxReal = 0.6;
				animSpeed = 7.5;
				action = "walk";
			}
		} else {
			frame--;
			if (frame <= 0) {
				frame = 0;
				action = "kick";
			}
			
			#region interaction
			var enemy = instance_place(x+round(sxReal), y, obj_enemy);
			if enemy {
				audio_play_sound(sfx_kick, 50, false);
				with enemy {
					instance_create_layer(x, bbox_top-16, "Front", obj_scorePopup, { frame : 0, value : 100, syReal : -0.75 });
					y -= 16;
					syReal = -3;
					fallCap = 3;
					action = "flip";
					state = false;
				}
			}
			
			var block = instance_place(x+round(sxReal), y, obj_block);
			if block {
				audio_play_sound(sfx_bump, 40, false);
				sxReal *= -1
				with block {
					smash = true;
					event_user(0);
				}
			}
			#endregion
			
		}
	}
} else {
	if (action != "flip") {
		state = !state;
		action = "shell";
		sxReal = 0;
	} else {
		syReal += 0.25;
	}
}