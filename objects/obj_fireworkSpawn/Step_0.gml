/// @description Raise Flag and trigger end events
y--;
if (y <= 112) { 
	y = 112;
	if spawn {
		//instance_create_layer(x, 50, "Instances_Front", obj_firework);
		if ((value == 1 || value == 3 || value == 6) && thing < value) {
				spawn = false;
				switch thing {
					case 0:
						instance_create_layer(x-10, 36, "Instances_Front", obj_firework);
					break;
					case 2:
						instance_create_layer(x+52, 52, "Instances_Front", obj_firework);
					break;
					case 3:
						instance_create_layer(x+52, 112, "Instances_Front", obj_firework);
					break;
					case 4:
						instance_create_layer(x+4, 52, "Instances_Front", obj_firework);
					break;
					case 1:
					case 5:
						instance_create_layer(x-40, 104, "Instances_Front", obj_firework);
					break;
				}
				thing++;
		} else {
			timer--;
			if (timer <= 0) {
				//room = obj_handler.roomTrans;
				room = rm_transition;
			}
		}
	}
}