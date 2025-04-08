/// @description Draw Self
global.colorMod[1][0].SetShader(global.palIdx);
draw_sprite_ext(spr_brickPart, 0, x, y, image_xscale, image_yscale, 0, c_white, 1);
shader_reset();