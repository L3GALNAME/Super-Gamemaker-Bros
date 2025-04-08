/// @description Variable Init

//Movement
sxReal = 4.5
if instance_exists(obj_player) { sxReal *= obj_player.dir; }

syReal = 3.5;
fallCap = 3.5;

inAir = 0;
onGround = false;

// Visual
state = "Move";

frame = 0;
animSpeed = 7.5;

xscale = 1;
yscale = 1;