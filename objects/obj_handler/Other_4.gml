/// @description Insert description here
if audio_group_is_loaded(audiogroup_mus2) {
	audio_group_unload(audiogroup_mus2)
}

global.layers = []
if (room != rm_start) {
    layer = layer_get_id("Front"); 
    global.layers[0] = layer_get_id("Tiles_Ground")
    global.layers[1] = layer_get_id("Tiles_Scenery")
    global.layers[2] = layer_get_id("Tiles_Sky")
	
	switch room {
		case rm_1_1_1:
			global.palIdx = 1;
			global.startPos = [32, 48];
			
			//global.time[0][1] = get_timer();
			//global.time[1][0] = 400.0;
			//global.time[2] = [0, 0, 0, 0];
		break;
		case rm_1_1:
			global.palIdx = 0;
			if levelComplete {
				global.time[0][1] = get_timer();
				global.time[1][0] = 400.0;
				global.time[2] = [0, 0, 0, 0];
				levelComplete = false;
				global.startPos = [48, 208];
				//global.startPos = [1448, 208];
				//global.startPos = [3016, 80];
			}
		break;
		case rm_1_2:
			global.palIdx = 1;
			if levelComplete {
				global.canMove = true;
				global.time[0][1] = get_timer();
				global.time[1][0] = 400.0;
				global.time[2] = [0, 0, 0, 0];
				levelComplete = false;
				global.startPos = [32, 48];
				//global.startPos = [1336, 80];
				//global.startPos = [3016, 80];
			}
		break;
		case rm_title:
			global.palIdx = 0;
			global.startPos = [48, 208];
			thing = 0;
		break;
		case rm_transition:
			thing = 150;
			if (roomTrans == rm_title) {
				lives = 3;
				thing = 30;
			}
			//thing = 150;
			//thing = 15;
			event_user(0);
			exit;
	}
	
	// Music/Background set
	music_set();
	
	//var background = layer_background_get_id("Background");
	//switch global.palIdx {
	//	case 0:
	//	case 3:
	//		layer_background_blend(background, #9494FF);
	//		break;
	//	case 1:
	//	case 2:
	//		layer_background_blend(background, #000000);
	//		break;
	//}
	
	instance_create_depth(0, 0, layer_get_depth(global.layers[0]) + 1, obj_palSetBegin, {
        palette : 0,
        set : global.palIdx
    });
    instance_create_depth(x, y, layer_get_depth(global.layers[0]) - 1, obj_palSetEnd);
    instance_create_depth(0, 0, layer_get_depth(global.layers[1]) + 1, obj_palSetBegin, {
        palette : 1,
        set : global.palIdx
    });
    instance_create_depth(x, y, layer_get_depth(global.layers[1]) - 1, obj_palSetEnd);
    instance_create_depth(0, 0, layer_get_depth(global.layers[2]) + 1, obj_palSetBegin, {
        palette : 2,
        set : global.palIdx
    });
    instance_create_depth(x, y, layer_get_depth(global.layers[2]) - 1, obj_palSetEnd);
	
	global.cameraVar[3] = 120

	if !instance_exists(obj_player) {
		instance_create_layer(global.startPos[0], global.startPos[1], "Front", obj_camera);
		instance_create_layer(global.startPos[0], global.startPos[1], "Instances_Front", obj_coinDraw);
		instance_create_layer(global.startPos[0], global.startPos[1], "Instances_Front", obj_blockDraw);
		instance_create_layer(global.startPos[0], global.startPos[1], "Instances_Front", obj_player);
		// Setup player variables during pipe exit
		if !array_length(playerVars) { 
			var pv = playerVars
			with obj_player { 
				if (pv == "Fire") {
					item[0] = 1;
					pv = "Big";
				}
				//item = 1;
				state = pv;
				sprite = pv == "Big" ? spr_marioBig : spr_marioSmall;
				
				if (room == rm_title) { global.canMove = false; }
			}
			exit;
		}
		var pv = playerVars;
		with obj_player {
			audio_play_sound(sfx_pipe, 75, false);
			global.canMove = pv[0]; state = pv[1]; action = pv[2];
			pipeDir = pv[3]; frame = pv[4]; animSpeed = pv[5];
			layer = layer_get_id("Instances_Back");
			timer = 64;
			if (pv[6] == "Fire") {
				item[0] = 1;
				pv[6] = "Big";
			}
			sprite = pv[6] == "Big" ? spr_marioBig : spr_marioSmall;
			
			if (room == rm_title) { global.canMove = false; }
		}
		playerVars = pv[6];
	}
}