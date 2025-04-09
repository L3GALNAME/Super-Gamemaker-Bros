/// @description Draw Self
//draw_txt(x-16, y-48, $"{x}, {y}");
//draw_txt(x-16, y-32, timer);
global.colorMod[0][0].SetShader(0+(2*item));

//if !global.canMove {
if (action == "pipe") {
	draw_sprite_ext(sprite, frame, round(x), round(y), dir, 1, 0, c_white, image_alpha);
	shader_reset();
	exit;
} else if (action == "pole") {
	draw_sprite_ext(sprite, 7+(floor(frame)%2), round(x), round(y), dir, 1, 0, c_white, image_alpha);
	shader_reset();
	exit;
}


//}

if (action != preAction) { frame = 0; }
animSpeed = 1/6

switch action {
    case "idle":
        draw_sprite_ext(sprite, 0, round(x), round(y), dir, 1, 0, c_white, image_alpha);
    break;
    case "jump":
        draw_sprite_ext(sprite, 5, round(x), round(y), dir, 1, 0, c_white, image_alpha);
    break;
    case "run":
        if (sxReal > sxCap) {
            animSpeed = (1+(2*(abs(sxReal)/(sxCap*2)))) / 6
        } else {
            animSpeed = (1+(1*(abs(sxReal)/(sxCap*2)))) / 6
        }
        
        frame += animSpeed;
        draw_sprite_ext(sprite, 1 + (floor(frame) mod 3), round(x), round(y), dir, 1, 0, c_white, image_alpha)
    break;
    case "skid":
        draw_sprite_ext(sprite, 4, round(x), round(y), dir*-1, 1, 0, c_white, image_alpha)
    break;
	case "crouch":
		draw_sprite_ext(sprite, 6, round(x), round(y), dir, 1, 0, c_white, image_alpha);
	break;
	case "die":
		draw_sprite_ext(sprite, 6, round(x), round(y), 1, 1, 0, c_white, image_alpha);
	break;
	case "fire":
		animSpeed = 15/60;
		draw_sprite_ext(spr_marioFire, 0, round(x), round(y), dir, 1, 0, c_white, image_alpha);
		frame += animSpeed;
		if (frame >= 1) { action = "idle"; }
	break;
}
shader_reset();