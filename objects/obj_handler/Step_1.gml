/// @description User Input
if global.canMove {
	for(var i=0; i<ctrlLen*2; i+=2) {
	    if (keyboard_check(global.keybinds[i]) or keyboard_check(global.keybinds[i+1])) {
	        global.ctrl[i/2]++;
	    } else { global.ctrl[i/2] = 0; }
	}
}

if keyboard_check_pressed(ord("R")) { game_restart() }

//if (keyboard_check_pressed(ord("B")) and instance_exists(obj_player)) {
//	global.canMove = !global.canMove;
//}

if (room == rm_transition) {
	thing--;
	if (thing <= 0) { 
		thing = 0;
		room = roomTrans;
	} else {
		exit;
	}
}

#region time control
	prePause = paused;

	global.time[0][0] = floor((get_timer() - global.time[0][1]) / 100000);
	
	if keyboard_check_pressed(vk_space) {
	    paused = !paused;
		if !audio_is_playing(sfx_pause) { audio_play_sound(sfx_pause, 100, false); }
		// Music set
		music_toggle();
	}
	
	if (pauseAnim) {
		paused = false;
		objectVars = [];
		pauseAnim = false;
	}
	
	if paused {
		if (prePause != paused) {
			// Time offset
			global.time[2][0] = global.time[0][0];
		}
		global.time[2][1] = global.time[0][0] - global.time[2][0]; // Time lost during pause
		global.time[2][2] = global.time[2][3] + global.time[2][1]; // Total time lost
	} else {
		if (prePause != paused) {
			instance_activate_all();
	        surface_free(paused_surf);
	        paused_surf = -1;
			sprite_delete(spr_custom);
			spr_custom = -1;
			global.canMove = true;
			
			// Stored time lost
			global.time[2][3] = global.time[2][2];
		}
		
		if (floor(global.time[1][1]) == 100 and !audio_is_playing(mus_warning) and !levelComplete) {
			if !audio_group_is_loaded(audiogroup_mus2) {
				audio_group_load(audiogroup_mus2);
			} else {
				music_toggle();
				audio_play_sound(mus_warning, 100, false);
			}
		}
	}
	
	// Level Timer
	if !levelComplete {
		global.time[1][1] = global.time[1][0] - ((global.time[0][0] - global.time[2][2]) / 4);
	} else {
		if (global.time[1][1] > 0 and !instance_exists(obj_player)) {
			global.time[1][1]--;
			score += 50;
			if (audio_sound_get_track_position(global.sound) >= 0.05) {
				audio_sound_set_track_position(global.sound, 1/60);
			}
		} else if (global.time[1][1] <= 0 and !audio_is_playing(global.sound)) {
			global.sound = sfx_coin;
		}
		global.time[1][1] = clamp(global.time[1][1], 0, 400.0);
	}
#endregion

frame = 7 * ((global.time[0][0] - global.time[2][2]) / 10);