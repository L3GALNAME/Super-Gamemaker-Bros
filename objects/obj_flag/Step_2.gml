/// @description Insert description here
if (place_meeting(x, y+4, obj_collision) and state) {
	y = 172;
	state = false;
	score += scored
	if instance_exists(obj_player) { 
		global.cameraVar[5] = obj_camera;
		with obj_player {
			syReal = 0;
			timer = 10;
			preD = -1;
			dir = preD;
			frame = 0;
			x += 16
		}
	}
} if place_meeting(x, y+5, obj_collision) {
	if (instance_exists(obj_player) and obj_player.state != "Win") {
		if (!audio_is_playing(mus_stageClear) and obj_player.onGround) {
			if !audio_group_is_loaded(audiogroup_mus2) {
				audio_group_load(audiogroup_mus2);
			} else { 
				audio_play_sound(mus_stageClear, 100, false);
			}
		}
		
		with obj_player {
			if place_meeting(x+sxReal, y, obj_collision) {
				global.cameraVar[5] = obj_camera;
				global.cameraVar[13] = 0;
				//audio_play_sound(sfx_coin, 75, false);
				global.sound = audio_play_sound(sfx_coin, 75, false);;
				instance_destroy();
			}
		}
	}
}