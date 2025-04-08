/// @description Varaible Init
dir = pipeD.DOWN;
dir2 = pipeD.DOWN;
startPos = [0, 0];
timer = 60;
roomSwitch = rm_1_1;
exitPipe = false;
marioState = "Small";

function enterPipe(_dir) {
	var playerState = "";
	playerState = obj_player.state;
	switch _dir {
		case pipeD.DOWN:
			with obj_player {
				//playerState = state;
				frame = 0;
				animSpeed = 0;
				if (sprite == spr_marioBig) { frame = 6; }
				pipeDir = _dir;
				timer = 61;
				event_user(5);
			}
		break;
		case pipeD.UP:
			with obj_player {
				//playerState = state;
				frame = 5;
				animSpeed = 0;
				pipeDir = _dir;
				timer = 61;
				event_user(5);
			}
		break;
		case pipeD.LEFT:
			with obj_player {
				//playerState = state;
				frame = 1;
				animSpeed = 15/60;
				pipeDir = _dir;
				timer = 61;
				event_user(5);
			}
		break;
		case pipeD.RIGHT:
			with obj_player {
				//playerState = state;
				frame = 1;
				animSpeed = 15/60;
				pipeDir = _dir;
				timer = 61;
				event_user(5);
			}
		break;
	}
	if (playerState == "Big" or playerState == "Crouch") { 
		marioState = "Big";
		if (obj_player.item == 1) { marioState = "Fire"; }
	}
	dir = -1;
}