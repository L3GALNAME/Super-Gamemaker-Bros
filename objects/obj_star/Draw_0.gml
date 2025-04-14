/// @description Draw self
frame += 30/60;
switch (floor(frame)%4) {
	case 0:
		// Player Color
		var item = instance_exists(obj_player);
		if item { item = obj_player.item[0]; }
		global.colorMod[1][4].SetShader(0+(2*item));
	break;
	case 1:
		// OW Green
		global.colorMod[1][4].SetShader(3+global.palIdx);
	break;
	case 2:
		// OW Red
		global.colorMod[1][4].SetShader(7);
	break;
	case 3:
		// Environment Color
		global.colorMod[1][4].SetShader(8+global.palIdx);
	break;
}
draw_sprite_ext(spr_star, 0, x+offset[0], y+offset[1], 1, 1, 0, c_white, 1);
shader_reset();
