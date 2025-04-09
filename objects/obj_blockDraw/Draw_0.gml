/// @description Insert description here
if instance_exists(obj_block) {
	global.colorMod[1][0].SetShader(global.palIdx);
	with obj_block {
		if (object_index != obj_blockM) {
			if state {
				draw_sprite_ext(spr_brick, 0+(global.palIdx==1), origPos[0]+offset[0], origPos[1]+offset[1], 1, 1, 0, c_white, image_alpha);
			} else {
				draw_sprite_ext(spr_brick, 2, x+offset[0], y+offset[1], 1, 1, 0, c_white, 1);
			}
		}
	}
	shader_reset();
}