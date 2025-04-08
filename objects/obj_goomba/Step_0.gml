/// @description Movement
preSX = sxReal;
if state {
	var fall = syReal>-1
    syReal += 0.25 + (0.75 * (fall and syReal<2));
	frame = animSpeed * ((global.time[0][0] - global.time[2][2]) / 10);
	if place_meeting(x+round(sxReal), y, obj_enemy) { sxReal *= -1; }
} else {
	if (action == "walk") {
		animSpeed++;
		if (animSpeed > 35) {
			instance_destroy();
		}
	} else {
		syReal += 0.25;
	}
}