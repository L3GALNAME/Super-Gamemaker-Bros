/// @description Draw self
global.colorMod[0][0].SetShader(15);
draw_sprite_ext(spr_explosion, floor(frame), x, y, 1, 1, 0, c_white, 1);
shader_reset();