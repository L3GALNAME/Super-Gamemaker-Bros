/// @description Insert description here
global.colorMod[1][5].SetShader(type*(global.palIdx+1));
draw_sprite(sprite_index, (type+1) % 2, x, y);
shader_reset();

if (state or place_meeting(x, y+5, obj_collision)) {
	draw_sprite(spr_score, array_get_index(global.points, scored), x+20, 176-(y-48));
}