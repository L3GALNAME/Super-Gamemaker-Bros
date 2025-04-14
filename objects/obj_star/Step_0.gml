/// @description Movement
preSX = sxReal;

switch state {
    case 0:
	    var fall = syReal>-1
		syReal += 0.125 + (0.025 * (fall and syReal<2));
		
		if onGround { syReal = -3; }
    break;
    case 1:
        offset[1] -= 0.5;
        if (offset[1] <= 0) {
			//sxReal = 1;
			sxReal = 1;
			//syReal = 1;
            offset[1] = 0;
            layer = layer_get_id("Instances_Front");
            state = 0;
        }
    break;
}