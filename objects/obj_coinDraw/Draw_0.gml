/// @description Insert description here
if instance_exists(obj_coin) or instance_exists(obj_blockM) {
	global.colorMod[1][3].SetShader((global.palIdx*3) + 
	(floor(frame%6) == 5 ? 
		// Goes back one color on frame 5, and stays static if before frame 3
		1 : ( floor((frame-2) % 6)*(frame%6 >= 3) )) 
	);

	frame = animSpeed * ((global.time[0][0] - global.time[2][2]) / 10);
	with obj_coin {
		draw_sprite_ext(spr_coin, 0, x, y, 1, 1, 0, c_white, 1);
	}
	
	with obj_blockM {
		if state { draw_sprite_ext(spr_block, 0, origPos[0]+offset[0], origPos[1]+offset[1], 1, 1, 0, c_white, image_alpha); }
	}
	
	shader_reset();
}