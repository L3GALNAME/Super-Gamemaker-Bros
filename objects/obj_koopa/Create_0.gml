/// @description Variable Init

// Visual
sprite = spr_koopa;
frame = 0;
animSpeed = 7.5;
dir = 1;
preD = dir;

state = true;
action = "walk"

// Movement
sxReal = -0.6;
preSX = sxReal;

syReal = 0;
fallCap = 5;

onGround = false;

// Enemy types
//// Jumpable, Fireflower-able
hitable = [true, true];
