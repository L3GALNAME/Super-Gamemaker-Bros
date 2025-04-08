/// @description Draw Self
global.colorMod[0][0].SetShader(15);
if (state == "boom") {
	draw_sprite_ext(spr_explosion, floor(frame), x, y, 1, 1, 0, c_white, 1);
} else {
	draw_sprite_ext(spr_fireball, 0, x, y, xscale, yscale, 0, c_white, 1);
}
shader_reset();