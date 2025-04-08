/// @description Draw/Animate
frame += animSpeed;

global.colorMod[0][0].SetShader(4);
draw_sprite_ext(spr_spinCoin, floor(frame), x+4, y, 1, 1, 0, c_white, 1);
shader_reset();