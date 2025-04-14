/// @description User Input
if global.canMove {
	for(var i=0; i<ctrlLen*2; i+=2) {
	    if (keyboard_check(global.keybinds[i]) or keyboard_check(global.keybinds[i+1])) {
	        global.ctrl[i/2]++;
	    } else { global.ctrl[i/2] = 0; }
	}
} else {
	for(var i=0; i<ctrlLen*2; i+=2) {
	    if (keyboard_check(global.keybinds[i]) or keyboard_check(global.keybinds[i+1])) {
	        global.ctrl2[i/2]++;
	    } else { global.ctrl2[i/2] = 0; }
	}
}

if keyboard_check_pressed(ord("R")) { game_restart() }

if keyboard_check_pressed(ord("B")) {
	global.canMove = !global.canMove;
}

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
	
	if (keyboard_check_pressed(vk_space) && !levelComplete && room != rm_title) {
	    paused = !paused;
		if paused { audio_stop_sound(sfx_pause); }
		if !audio_is_playing(sfx_pause) { audio_play_sound(sfx_pause, 100, false); }
		// Music set
		music_toggle();
	} else if (room == rm_title) {
		score = 0;
		global.coins = 0;
		
		#region title timing
			switch thing {
				case 0:
				case 909:
				case 970:
				case 1130:
				case 1399:
					event_user(0);
				break;
				
				case 480:
				case 1134:
					global.ctrl[3] = 2;
				break;
				
				case 932:
				case 974:
					global.ctrl[5] = 2;
					global.ctrl[3] = 2;
				break;
				
				case 629:
				case 711:
				case 814:
				case 904:
				case 981:
				case 1054:
				case 1219:
					global.ctrl[0] = 2;
				break;
				
				case 640:
				case 667:
				case 721:
				case 834:
				case 1000:
				case 1074:
				case 1239:
					global.ctrl[0] = 0;
				break;
				
				case 644:
				case 782:
				case 1349:
					global.ctrl[3] = 0;
					global.ctrl[1] = 2;
				break;
				
				case 664:
					global.ctrl[3] = 2;
					global.ctrl[1] = 0;
					global.ctrl[0] = 2;
				break;
				
			}
			thing++;
		#endregion
		
		if (array_contains(global.ctrl2, true) && thing >= 480) { room = rm_transition; }
		else if (global.ctrl2[4] == 1) {
			roomTrans = rm_1_1;
			room = rm_transition;
			global.canMove = true;
		}
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
			global.canMove = (room != rm_title);
			
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
			// Level ending
			global.time[1][1]--;
			score += 50;
			if (audio_sound_get_track_position(global.sound) >= 0.05) {
				audio_sound_set_track_position(global.sound, 1/60);
			}
		} else if (global.time[1][1] <= 0 and !audio_is_playing(global.sound) and !instance_exists(obj_fireworkSpawn)) {
			// Spawn castle Flag
			global.sound = sfx_coin;
			if instance_exists(obj_camera) { instance_create_layer(obj_camera.x + 135, 134, "Instances_Back", obj_fireworkSpawn, { value : thing }); }
		}
		global.time[1][1] = clamp(global.time[1][1], 0, 400.0);
	}
#endregion

frame = 7 * ((global.time[0][0] - global.time[2][2]) / 10);