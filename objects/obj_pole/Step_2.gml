/// @description Insert description here
if place_meeting(x, y, obj_player) {
	var _x = x;
	global.canMove = false;
	with obj_player {
		state = "Win";
		action = "pole";
		x = _x - 3;
		y -= syReal;
		sxReal = 0;
		syReal = 2;
		dir = 1;
		timer = 0;
		frame = 0;
		animSpeed = 15/60;
	}
	with obj_flag { event_user(0); }
	with obj_handler {
		event_user(0);
		levelComplete = true;
	}
	
	audio_group_stop_all(audiogroup_default);
	audio_play_sound(sfx_flagpole, 100, false);
	
	instance_destroy();
}