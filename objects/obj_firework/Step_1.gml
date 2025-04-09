/// @description Animation
frame += animSpeed;
if (frame >= 3) {
	score += 500;
	obj_fireworkSpawn.alarm[0] = 10;
	instance_destroy();
}