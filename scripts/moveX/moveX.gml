// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function moveX(sx, object=obj_handler) {
    var spdX = sx;
    var sx2 = sx;
    if instance_exists(obj_collision) {
        
        if (place_meeting(x+spdX, y, obj_collision) or (object == obj_player and place_meeting(x+spdX, y, obj_collisionCamera))) {
			var collision = true;
			for (var i=1; i<7; i++) {
				if !place_meeting(x+spdX, y-i, obj_collision) {
					y -= i;
					i = 8;
					collision = false;
				}
			}
			
			if collision { spdX = round(sx); }
        }
        
        while (place_meeting(x+spdX, y, obj_collision) or (object == obj_player and place_meeting(x+spdX, y, obj_collisionCamera))) {
            var bruh = place_meeting(x, y, obj_collision) // Stuck inside object
            if (spdX > 0) {
                spdX--;
                if bruh {
                    // Stuck
                    while place_meeting(x+spdX, y, obj_collision) {
                        spdX--;
                    }
                }
            } else {
                spdX++;
                if bruh {
                    // Stuck
                    while place_meeting(x+spdX, y, obj_collision) {
                        spdX--;
                    }
                }
            }
            sx2 = 0;
        }
    }
    x += spdX;
    return sx2;
}