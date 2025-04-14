/// @description Movement
preD = dir;
preSX = sxReal;
preAction = action;
var xdir, absX, dir2;

//sprite = asset_get_index($"spr_mario{state}");
sprite_index = spr_playerSmall;

iframe--;
if (iframe <= 0) { iframe = 0; }

switch state {
	case "Win":
		#region Level Complete
			if (timer == 0) {
				if onGround {
					animSpeed = 0;
					frame = 0;
					syReal = 0;
					y -= 2;
					exit;
				}
				frame += animSpeed;
			} else {
				timer++;
				if (timer >= 35) {
					x += 4;
					y += 2;
					sxReal = 0.05;
					global.ctrl[3] = 2;
					global.cameraVar[5] = obj_player;
					global.cameraVar[13] = -16;
					state = "Small";
					if (sprite == spr_marioBig) {
						state = "Big";
					}
				}
			}
		#endregion
	break;
	case "Pipe":
		action = "pipe";
		#region Pipe Animation
		if (timer <= 0) {
			//state = "Small";
			state = obj_handler.playerVars;
			obj_handler.playerVars = [];
			action = "transform";
			global.canMove = true;
			layer = layer_get_id("Instances_Front");
			exit;
		}
		frame += animSpeed;
		switch pipeDir {
			case pipeD.DOWN:
				y++;
			break;
			case pipeD.UP:
				y--;
			break;
			case pipeD.RIGHT:
				if (round(frame) >= 4) { frame = 1; }
				x += 0.5;
				image_alpha = timer > 30;
			break;
			case pipeD.LEFT:
				if (round(frame) >= 4) { frame = 1; }
				x -= 0.5;
				image_alpha = timer > 30;
			break;
		}
		timer--;
		#endregion
	break;
	case "Die":
		sprite = spr_marioSmall;
		action = "die";
	break;
	case "Crouch":
		//if !global.canMove { exit; }
		#region Crouching
		sprite_index = spr_playerSmall;
		sprite = spr_marioBig;
		// Speed Set
        xdir = preD;
        xdir = (global.ctrl[3] > 0) - (global.ctrl[1] > 0);
        sxReal += 0.05 * xdir * !onGround;
        absX = abs(sxReal);
        
        // Speed Capped
        if (absX > 0) {
            dir2 = absX / sxReal;
            if (xdir == 0 or onGround) {
                // No button pressed/touching ground decelerate
                sxReal = (absX - (0.05 * (1+(absX > sxCap)))) * dir2;
            } else if (absX > sxCap*2) {
                // Running Cap
                sxReal = sxCap*2 * dir2;
            } else if ((absX > sxCap and !running and abs(preSX) <= sxCap) or (absX > sxCap and !onGround and abs(preSX) <= sxCap)) {
                // Walking cap/Jump speed cap
                sxReal = sxCap * dir2;
            } else {
                if (absX >= sxCap-1 and xdir / dir2 == -1 and onGround) {
                    // Skid
                    sxReal = (absX - 0.2) * dir2
                }
            }
            if (!running and absX > sxCap and abs(preSX) > sxCap) {
                // Decelerate from running
                sxReal = (absX - 0.1) * dir2;
            }
        }
        
        if (absX < 0.05) {
            sxReal = 0;
        }
        absX = abs(sxReal);
        
        // Jumping
		mario_jumping(absX);
        
        #region interaction
            var blockHit = instance_place(x, y-4, obj_block);
            sprite_index = spr_marioSmall;
            if !blockHit { blockHit = instance_place(x, y-2, obj_block); }
            if (blockHit and syReal < 0) {
				audio_stop_sound(sfx_jumpSuper);
				if !audio_is_playing(sfx_bump) { audio_play_sound(sfx_bump, 50, false); }
				inAir = jumpCap;
				syReal = 0;
                with(blockHit) {
					smash = true;
					event_user(0);
				}
            }
			
			mushroom_place(2 * !item[0]);
			star_place(item[1]);
			enemy_place();
			coin_place();
        #endregion
		
		if (global.ctrl[2] == 0 and onGround) { 
			state = "Big";
		}
		#endregion
	break;
    case "Big":
		//if !global.canMove { exit; }
		#region Super Mario
		sprite_index = spr_playerBig;
		sprite = spr_marioBig;
		// Speed Set
        xdir = preD;
        xdir = (global.ctrl[3] > 0) - (global.ctrl[1] > 0);
        running = global.ctrl[5] > 0;
        sxReal += 0.05 * xdir;
        absX = abs(sxReal);
        
        // Speed Capped
		dir2 = 0;
		mario_run(absX, dir2, xdir)
		
        absX = abs(sxReal);
        
        // Jumping
		mario_jumping(absX);
        
        #region interaction
            var blockHit = instance_place(x, y-4, obj_block);
            sprite_index = sprite;
            if !blockHit { blockHit = instance_place(x, y-2, obj_block); }
            if (blockHit and syReal < 0) {
				audio_stop_sound(sfx_jumpSuper);
				if !audio_is_playing(sfx_bump) { audio_play_sound(sfx_bump, 50, false); }
				inAir = jumpCap;
				syReal = 0;
                with(blockHit) {
					smash = true;
					event_user(0);
				}
            }
			
			mushroom_place(2 * !item[0]);
			star_place(item[1]);
			enemy_place();
			coin_place();
        #endregion
		
		if (global.ctrl[2] > 0 and onGround) { 
			state = "Crouch";
			action = "crouch";
			running = false;
		}
		
		// Spawn fireball
		if (global.ctrl[5] == 1 and item[0]) {
			audio_play_sound(sfx_fireball, 50, false);
			instance_create_layer(x+(8*dir), bbox_top, layer, obj_fireball);
			action = "fire";
		}
		#endregion
	break;
	case "Small":
		//if !global.canMove { exit; }
		#region (regular) Mario
		sprite = spr_marioSmall;
		
        // Speed Set
        xdir = preD;
        xdir = (global.ctrl[3] > 0) - (global.ctrl[1] > 0);
        running = global.ctrl[5] > 0;
        sxReal += 0.05 * xdir /** (1+running)*/;
        absX = abs(sxReal);
        
        // Speed Capped
		dir2 = 0;
		mario_run(absX, dir2, xdir);
        absX = abs(sxReal);
        
        // Jumping
		mario_jumping(absX)
        
        #region interaction
            var blockHit = instance_place(x, y-4, obj_block);
            sprite_index = sprite;
            if !blockHit { blockHit = instance_place(x, y-2, obj_block); }
            if (blockHit and syReal < 0) {
				audio_stop_sound(sfx_jumpSmall);
				if !audio_is_playing(sfx_bump) { audio_play_sound(sfx_bump, 50, false); }
                with(blockHit) { event_user(0); }
            }
			
			mushroom_place(1);
			star_place(item[1]);
			enemy_place();
			coin_place();
        #endregion
		#endregion
	break;
}
