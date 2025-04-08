/// @description Movement
preSX = sxReal;

switch state {
    case 0:
		if !flower {
	        var fall = syReal>-1
		    syReal += 0.25 + (0.75 * (fall and syReal<2));
		}
    break;
    case 1:
        offset[1] -= 0.5;
        if (offset[1] <= 0) {
			sxReal = 1*(!flower);
            offset[1] = 0;
            layer = layer_get_id("Instances_Front");
            state = 0;
        }
    break;
}