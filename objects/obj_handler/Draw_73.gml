/// @description Insert description here
if (room == rm_transition) { exit; }
if paused {
    if !surface_exists(paused_surf) {
        if (paused_surf == -1) { 
            instance_deactivate_all(true);
            //instance_activate_object(obj_palSetBegin);
            //instance_activate_object(obj_palSetEnd);
			instance_activate_object(obj_scorePopup);
        }
        paused_surf = surface_create(256, 224);
		spr_custom = sprite_create_from_surface(application_surface, 0, 0, 256, 224, false, false, 0, 0);
        surface_set_target(paused_surf);
		draw_sprite(spr_custom, 0, 0, 0);
        surface_reset_target();
    } else {
		if (array_length(objectVars) >= 4) {
			surface_set_target(paused_surf);
			draw_clear(c_white);
			draw_sprite(spr_custom, 0, 0, 0);
			switch objectVars[0] {
				//// Reference obj_player for values
				case "die":
					#region die
					// Animate
					objectVars[2]++
					if (objectVars[2] <= 15) {
						objectVars[6] = 0;
					} else if (objectVars[2] < 25) {
						objectVars[6] = -3.5;
					} else if (objectVars[2] < 180) {
						// Gravity
						objectVars[6] += 0.25
						if (objectVars[6] > 6) { objectVars[6] = 6; }
					} else {
						pauseAnim = true;
						room_restart()
					}
					
					// Apply Position
					if (objectVars[5] < room_height+28) {
						objectVars[5] += objectVars[6]
					
						global.colorMod[0][0].SetShader(objectVars[3]);
						draw_sprite_ext(spr_marioSmall, 6, objectVars[4], objectVars[5], 1, 1, 0, c_white, 1);
						shader_reset();
					}
					
					#endregion
				break;
				case "transform":
					#region transform
					objectVars[2] += objectVars[3];
					switch objectVars[1] {
						case "Small":
							#region Shrink
							global.colorMod[0][0].SetShader(objectVars[4]);
							switch floor(objectVars[2]) {
								case 1:
								case 3:
								case 5:
									draw_sprite_ext(spr_marioBig, 5, objectVars[5], objectVars[6], objectVars[7], 1, 0, c_white, 1);
									break;
								case 6:
								case 11:
								case 13:
								case 16:
								case 18:
								case 20:
									draw_sprite_ext(spr_marioBig, 9, objectVars[5], objectVars[6], objectVars[7], 1, 0, c_white, 1);
									break;
								case 8:
								case 10:
								case 15:
								case 21:
									draw_sprite_ext(spr_marioSmall, 9, objectVars[5], objectVars[6], objectVars[7], 1, 0, c_white, 1);
									break;
							}
							if (objectVars[2] >= 23) {
								pauseAnim = true;
							}
							#endregion
						break;
						case "Big":
							#region Grow
							global.colorMod[0][0].SetShader(objectVars[4]);
							switch floor(objectVars[2]) {
								case 0:
								case 2:
								case 4:
								case 7:
									draw_sprite_ext(spr_marioSmall, 0, objectVars[5], objectVars[6], objectVars[7], 1, 0, c_white, 1);
									break;
								case 1:
								case 3:
								case 5:
								case 8:
									draw_sprite_ext(spr_marioBig, 15, objectVars[5], objectVars[6], objectVars[7], 1, 0, c_white, 1);
									break;
								case 6:
								case 9:
									draw_sprite_ext(spr_marioBig, 0, objectVars[5], objectVars[6], objectVars[7], 1, 0, c_white, 1);
									break;
							}
							if (objectVars[2] >= 10) {
								pauseAnim = true;
							}
							#endregion
						break;
						case "Fire":
							#region Fire
							switch (floor(objectVars[2]) mod 4) {
								case 0:
									global.colorMod[0][0].SetShader(2);
								break;
								case 1:
									global.colorMod[0][0].SetShader(3 + (global.palIdx*3));
								break;
								case 2:
									global.colorMod[0][0].SetShader(3 + ((global.palIdx*3)+1) );
								break;
								case 3:
									global.colorMod[0][0].SetShader(3 + ((global.palIdx*3)+2) );
								break;
							}
							draw_sprite_ext(spr_marioBig, 1, objectVars[4], objectVars[5], objectVars[6], 1, 0, c_white, 1);
							
							if (objectVars[2] >= 10) {
								pauseAnim = true;
							}
							#endregion
						break;
					}
					shader_reset();
					
					#endregion
				break;
			}
			surface_reset_target();
		}
		
		draw_surface(paused_surf, camera_get_view_x(global.camera), 8);
    }
}