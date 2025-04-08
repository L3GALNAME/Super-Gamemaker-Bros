/// @description Draw self
global.colorMod[0][2].SetShader(global.palIdx);

switch action {
	case "walk":
		draw_sprite_ext(sprite, floor(frame)%2, x, y-3, dir, 1, 0, c_white, 1);
	break;
	case "shell":
		draw_sprite_ext(sprite, frame<28 ? 4 : (4+(floor(frame)%2)), x, y-3, 1, 1, 0, c_white, 1);
	break;
	case "flip":
		draw_sprite_ext(sprite, 4, x, y-6, 1, -1, 0, c_white, 1);
	break;
	default:
		draw_sprite_ext(sprite, 4, x, y-3, 1, 1, 0, c_white, 1);
	break;
}

shader_reset();