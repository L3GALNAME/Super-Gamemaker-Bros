/// @description Check for player collision/Input
if !instance_exists(obj_player) { exit; }
switch dir {
	case pipeD.DOWN:
		if (place_meeting(x, y-2, obj_player) and global.ctrl[2] > 0
		and (bbox_right - obj_player.bbox_left <= 18 and obj_player.bbox_right - bbox_left <= 18) ) {
			// Ensures the player isn't clipping outside the pipe
			enterPipe(dir);
		}
	break;
	case pipeD.UP:
		if (place_meeting(x, y+2, obj_player) and global.ctrl[0] > 0
		and (bbox_right - obj_player.bbox_left <= 18 and obj_player.bbox_right - bbox_left <= 18) ) {
			// Same clipping rule
			enterPipe(dir);
		}
	break;
	case pipeD.LEFT:
		if (place_meeting(x+2, y, obj_player) and obj_player.onGround and global.ctrl[1] > 0) {
			enterPipe(dir);
		}
	break;
	case pipeD.RIGHT:
		if (place_meeting(x-2, y, obj_player) and obj_player.onGround and global.ctrl[3] > 0) {
			enterPipe(dir);
		}
	break;
	case -1:
		timer--;
		if (timer <= 0) {
			if exitPipe {
				//Sets player creation variables
				obj_handler.playerVars = [
					false, // canMove
					"Pipe", // state
					"pipe", // action
					dir2, // pipeDir
					undefined, // frame
					undefined, // animSpeed
					marioState, // state after transition
				];
			
				switch dir2 {
					case pipeD.DOWN:
						obj_handler.playerVars[4] = 0;
						obj_handler.playerVars[5] = 0;
					break;
					case pipeD.UP:
						obj_handler.playerVars[4] = 0;
						obj_handler.playerVars[5] = 0;
					break;
					case pipeD.LEFT:
						obj_handler.playerVars[4] = 1;
						obj_handler.playerVars[5] = 15/60;
					break;
					case pipeD.RIGHT:
						obj_handler.playerVars[4] = 1;
						obj_handler.playerVars[5] = 15/60;
					break;
				}
			} else {
				obj_handler.playerVars = marioState;
			}
			
			global.startPos = startPos;
			room = roomSwitch;
			instance_destroy();
		}
	break;
}