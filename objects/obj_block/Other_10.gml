/// @description Block hit
if (!hit and state) {
    image_alpha = 1;
    thing = -2;
    offset[1] += thing;
    hit = true;
    
    if (item != Items.COIN) {
        amount = 0;
		if (item != Items.EMPTY) { audio_play_sound(sfx_itemAppear, 75, false); }
    } else {
		audio_play_sound(sfx_coin, 50, false);
		timer = amount - 1;
        instance_create_depth(x, y-16, depth-1, obj_spinCoin);
        amount--;
    }
    
	#region Item hit
	// Coin hit ! :D
	var coin = instance_place(x, y-4, obj_coin);
	if coin {
		audio_play_sound(sfx_coin, 50, false);
		with coin { 
			instance_create_layer(x+0, y, "Instances_Front", obj_spinCoin);
			instance_destroy();
		}
	}
	
	// Mushroom bounce ! :D
	var mushroom = instance_place(x, y-4, obj_mushroom);
	if mushroom {
		with mushroom { 
			syReal = -3.5;
			sxReal *= -1
		}
	} else {
		mushroom = instance_place(x, y-4, obj_player) }
		if mushroom {
		with mushroom { 
			syReal = -3.5;
		}
	}
	
	// Enemy hit !
	var enemy = instance_place(x, y-4, obj_enemy);
	if (enemy and enemy.action != "flip" ) {
		audio_play_sound(sfx_kick, 50, false);
		with enemy {
			instance_create_layer(x, bbox_top-16, "Front", obj_scorePopup, { value : 100, syReal : -0.75 });
			y -= 16;
			syReal = -3;
			fallCap = 3;
			action = "flip";
			state = false;
		}
	}
	#endregion
	
    if (item != Items.EMPTY and amount <= 0) {
        amount = 0;
        state = false;
    } else if (item == Items.EMPTY and smash) {
		audio_play_sound(sfx_brickSmash, 50, false);
		instance_create_layer(x+12, y+4, "Front", obj_brickPart, { sxReal : 1, syReal : -5.5 } );
		instance_create_layer(x+4, y+4, "Front", obj_brickPart, { sxReal : -1, syReal : -5.5 } );
		instance_create_layer(x+12, y+12, "Front", obj_brickPart, { sxReal : 1, syReal : -3.5 } );
		instance_create_layer(x+4, y+12, "Front", obj_brickPart, { sxReal : -1, syReal : -3.5 } );
		
		score += 50;
		instance_destroy();
	}
}