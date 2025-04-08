/// @description Animation
if (hit) {
    if (offset[1] >= 0) {
        offset[1] = 0
        thing = 0;
        hit = false;
        
        switch item {
            case Items.MUSHROOM:
                instance_create_layer(x+8, y, "Instances_Back", obj_mushroom, { 
                    type : 0, state : 1, flower : (instance_exists(obj_player) and obj_player.state != "Small")
                });
            break;
            case Items.ONEUP:
                instance_create_layer(x+8, y, "Instances_Back", obj_mushroom, { 
                    type : 1, state : 1, flower : false
                });
            break;
        }
    }
    thing += 0.3;
    offset[1] += thing;
}