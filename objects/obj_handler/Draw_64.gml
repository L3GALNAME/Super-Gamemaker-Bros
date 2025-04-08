/// @description Draw Numbers
var scoreStr = $"{score}"
var coinStr = $"{global.coins}"
var levelStr = string_replace_all(room_get_name(roomTrans), "_", "-")
levelStr = string_copy(levelStr, 4, 3);

if (room == rm_transition) {
	// Score section
	draw_txt(24, 8, "MARIO");
	
	draw_txt(24, 16, string_repeat("0", (6-string_length(scoreStr))) + scoreStr);

	// Coin section
	global.colorMod[1][3].SetShader(3);
	draw_sprite(spr_coinGUI, 0, 88, 16);
	shader_reset();
	
	draw_txt(96, 16, "*" + string_repeat("0", (2-string_length(coinStr))) + coinStr);
	// Level
	draw_txt(144, 8, $"WORLD`n {levelStr}");
	draw_txt(88, 72, $"WORLD {levelStr}");

	// Timer section
	draw_txt(200, 8, "TIME");
	
	draw_sprite(spr_marioSmall, 0, 104, 109);
	draw_txt(120, 100, $"*  3");
} else {
	// Score section
	draw_txt(24, 8, "MARIO");
	draw_txt(24, 16, string_repeat("0", (6-string_length(scoreStr))) + scoreStr);

	// Coin section
	global.colorMod[1][3].SetShader((global.palIdx*3) + 
	(floor(frame%6) == 5 ? 
		// Goes back one color on frame 5, and stays static if before frame 3
		1 : ( floor((frame-2) % 6)*(frame%6 >= 3) )) 
	);
	draw_sprite(spr_coinGUI, 0, 88, 16);
	shader_reset();

	draw_txt(96, 16, "*" + string_repeat("0", (2-string_length(coinStr))) + coinStr);

	// Level
	draw_txt(144, 8, "WORLD`n 1-1");

	// Timer section
	draw_txt(200, 8, "TIME");
	draw_txt(208 + (8 * (3-string_length($"{floor(global.time[1][1])}"))), 16, floor(global.time[1][1]));
}
