/// @description Variable Init

// Camera
global.cameraVar[4] = 1;
global.cameraVar[5] = obj_player;

// Visual
dir = 1;
preD = dir;
// Animation
state = "Small";
action = "transform";
preAction = action;
animSpeed = 1/6;
sprite = asset_get_index($"spr_mario{state}");

// Movement
sxReal = 0;
sxCap = 1.5;

syReal = 0;
jumpSpd = -3.5;
jumpCap = 12;
fallCap = 6;

// No Touch
inAir = 0;
onGround = false;
running = false;
preSX = sxReal;
iframe = 0;
pipeDir = 0;
timer = 0;

frame = 0;

luigi = 0;
item = [0, 0, 0]; // 0 for none, [0] for fire, [1] for star

#region Functions
function mario_run(_absX, _dir2, _xdir) {
	if (action != "fire") { action = "run"; }
	
	if (_absX > 0) {
	    _dir2 = _absX / sxReal;
	    if (_xdir == 0) {
	        // No button pressed decelerate
	        sxReal = (_absX - (0.05 * (1+(_absX > sxCap)))) * _dir2;
	    } else if (_absX > sxCap*2) {
	        // Running Cap
	        sxReal = sxCap*2 * _dir2;
	    } else if ((_absX > sxCap and !running and abs(preSX) <= sxCap) or (_absX > sxCap and !onGround and abs(preSX) <= sxCap)) {
	        // Walking cap/Jump speed cap
	        sxReal = sxCap * _dir2;
	    } else {
	        if (_absX >= sxCap-1 and _xdir / _dir2 == -1 and onGround) {
	            // Skid
	            sxReal = (_absX - 0.2) * _dir2
	            action = "skid"
	        }
	    }
	    if (!running and _absX > sxCap and abs(preSX) > sxCap) {
	        // Decelerate from running
	        sxReal = (_absX - 0.1) * _dir2;
	    }
	}
        
	if (_absX < 0.05) {
	    sxReal = 0;
	    if (action != "fire") { action = "idle"; }
	}
}

function mario_jumping(_absX) {
	var fall = syReal>-1
    jumpCap = 12 + ceil(3 * (_absX/(sxCap*2)))
	
    if (global.ctrl[0] > 0 and inAir < jumpCap) {
		if onGround {
			if (state == "Small") {
				audio_play_sound(sfx_jumpSmall, 75, false);
			} else {
				audio_play_sound(sfx_jumpSuper, 75, false);
			}
		}
        syReal = jumpSpd - (0.4 * (_absX/(sxCap*2)));
    } else {
        inAir = jumpCap;
		syReal += 0.25 + (0.75 * (fall and syReal<3));
		//if (_absX >= sxCap*2 and (
		//	(!place_meeting(x+_absX, y+8, obj_collision) or !place_meeting(x+(_absX*2), y+8, obj_collision))
		//	and (place_meeting(x+(_absX*2), y+8, obj_collision) or place_meeting(x+(_absX*3), y+8, obj_collision)) 
		//)) {
		//	// The most RAMBUNCTIOUS code I've ever written
		//	// Checks if there's no collision under the player for a certain range,
		//	// and then if there IS collision a little further
		//	// (it's the one tile gap run thing)
		//	syReal += 0.2;
		//} else {
		//	syReal += 0.25 + (0.75 * (fall and syReal<3));
		//}
    }	
}

function mushroom_place(trans=0) {
	var mushroom = instance_place(x, y, obj_mushroom);
	if mushroom {
		var mushType = 0;
		with mushroom {
			mushType = type;
			if mushType {
				// 1UP
				instance_create_layer(bbox_left, bbox_top-16, "Front", obj_scorePopup, { value : "1UP", syReal : -1 })
				audio_play_sound(sfx_1up, 75, false);
			} else {
				// Super Mushroom
				instance_create_layer(bbox_left, bbox_top-16, "Front", obj_scorePopup, { value : 1000, syReal : -1 })
			}
			instance_destroy();
		}
		if !mushType {
			audio_play_sound(sfx_powerup, 75, false);
			// trans: 1 = big, 2 = fire
			switch trans {
				case 1:
					event_user(0);
				break;
				case 2:
					event_user(2);
				break;
			}
		}
	}	
}

function star_place(inv=0) {
	var star = instance_place(x, y, obj_star);
	if star {
		with star {
			instance_destroy();
		}
		item[1] = 60 * 12;
		if audio_is_playing(sfx_powerup) {
			audio_stop_sound(sfx_powerup);
			audio_play_sound(sfx_powerup, 75, false);
		}
		if !string_pos(audio_get_name(global.sound), "mus_invincible") {
			audio_stop_sound(global.sound);
			global.sound = audio_play_sound(mus_invincible, 100, true);
		}
	}
}

function enemy_place() {
	var enemy = instance_place(x+sxReal, bbox_bottom+syReal, obj_enemy);
	if (enemy && enemy.state) {
		if item[1] {
			var scored = global.points[item[2]];
			if (scored == "1UP") { 
				if audio_is_playing(sfx_1up) { audio_stop_sound(sfx_1up); }
				audio_play_sound(sfx_1up, 50, false); 
			} else {
				audio_play_sound(sfx_kick, 50, false);
			}
			
			with enemy {
				instance_create_layer(x, bbox_top-16, "Front", obj_scorePopup, { value : scored, syReal : -0.75 });
				y -= 16;
				syReal = -3;
				fallCap = 3;
				action = "flip";
				state = false;
			}
			
			item[2]++;
			item[2] = clamp(item[2], 0, 10);
		} else if (enemy.hitable[0] and (!place_meeting(bbox_right, bbox_bottom, obj_enemy) and !place_meeting(bbox_left, bbox_bottom, obj_enemy))) {
			if (enemy.action == "shell") { exit; }
			syReal = jumpSpd + 0.5;
			with enemy {
				instance_create_layer(x, bbox_top-16, "Front", obj_scorePopup, { value : 100, syReal : -0.75 })
				state = false;
				frame = 0;
				animSpeed = 0;
			}
			audio_play_sound(sfx_stomp, 50, false);
		} else if (iframe <= 0) {
			if (enemy.action == "shell") {
				if !audio_is_playing(sfx_kick) { audio_play_sound(sfx_kick, 50, false); }
				exit;
			}
			iframe = 180;
			switch state {
				case "Crouch":
				case "Big":
					item[0] = 0;
					event_user(1);
				break;
				case "Small":
					event_user(4);
					layer = layer_get_id("Front");
				break;
			}
		}
	}
}

function coin_place() {
	var coin = instance_place(x, y, obj_coin);
	if coin {
		audio_play_sound(sfx_coin, 50, false);
		with coin {
			global.coins++;
			score += 200;
			instance_destroy()
		}
	}	
}
#endregion