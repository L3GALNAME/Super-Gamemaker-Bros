/// @description Variable Init

// Visual
sprite = spr_pPlant;
frame = 0;
animSpeed = 7.5;

origY = y + 24;
y = origY;

state = true;
action = undefined;

// Movement
sxReal = 0.6;
syReal = 0;
fallCap = 5;

timer = 0;

// Enemy types
//// Jumpable, Fireflower-able
hitable = [false, true];