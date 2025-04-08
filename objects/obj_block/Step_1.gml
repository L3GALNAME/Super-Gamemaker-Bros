/// @description Reset Position
x = origPos[0];
y = origPos[1];

timer -= 1/60;
if (timer <= 0) {
	timer = 0;
} else if (timer <= amount-1) {
	amount--;
}

if (image_alpha != 0) {
    sprite_index = spr_block;
    exit;
}

sprite_index = spr_invisMask;