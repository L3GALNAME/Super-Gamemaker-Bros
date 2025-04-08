/// @description trigger slide
state = true;
scored = global.points[8 - round((obj_player.bbox_bottom - 48) / 18)]; // 18 comes from the height of the pole (y 192 - y 48)