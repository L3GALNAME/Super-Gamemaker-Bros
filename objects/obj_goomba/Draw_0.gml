/// @description Draw self
global.colorMod[0][1].SetShader(global.palIdx);
if (action == "walk") {
	draw_sprite_ext(spr_goomba, !state, x, y-4, 1-(2*(floor(frame)%2)), 1, 0, c_white, 1);
} else {
	draw_sprite_ext(spr_goomba, 0, x, y-4, 1-(2*(floor(frame)%2)), -1, 0, c_white, 1);
}
shader_reset();