// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function moveY(sy, falling=false, objReturn=false, object=obj_handler, airCount=0, hold=0, cap=12) {
    var spdY = sy
    if falling { spdY = floor(sy); }
    var sy2 = sy;
    var air = airCount;
    var ground = false;
    air++;
    if instance_exists(obj_collision) {
		if (place_meeting(x, y+spdY, obj_collision) and !falling) {
			//var collision = true;
			for (var i=1; i<4; i++) {
				if !place_meeting(x+i, y+spdY, obj_collision) {
					x += i;
					i = 5;
					//collision = false;
				}
				if !place_meeting(x-i, y+spdY, obj_collision) {
					x -= i;
					i = 5;
				}
			}
		}
		
        while (place_meeting(x, y+spdY, obj_collision) or (object == obj_player and instance_place(x, y+spdY, obj_collisionCamera))) {
            if (spdY > 0) {
                spdY--;
                air = air*(hold>4);
                ground = true;
                sy2 = spdY;
            } else {
                spdY++;
                air = cap+2;
                sy2 = 0;
            }
        }
    }
    y += spdY;
    if objReturn {
        object.inAir = air;
        object.onGround = ground;
    }
    return sy2;
}