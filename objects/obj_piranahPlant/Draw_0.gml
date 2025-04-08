/// @description Insert description here
global.colorMod[0][2].SetShader(global.palIdx);
draw_sprite_ext(spr_pPlant, frame%2, x, y, 1, 1, 0, c_white, 1);
shader_reset();