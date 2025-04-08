	/// @description Application

if (state == "Die" or state == "Pipe") {
	//y += syReal
	exit;
}

// Application
var fall = syReal>-1;
sxReal = moveX(sxReal, obj_player);
syReal = moveY(syReal, fall, true, obj_player, inAir, global.ctrl[0], jumpCap);
if (syReal > fallCap) { syReal = fallCap; }

if (!onGround and (action != "transform" and action != "crouch" and action != "fire" and action != "pipe" and action != "pole")) { action = "jump"; }
    
// Correct Direction
dir = ((x > xprevious) - (x < xprevious)) * onGround;
if (dir == 0) { dir = preD; }
if (action == "crouch") { dir = preD; }
image_xscale = dir;

image_alpha = 1;
if (iframe > 60) { 
	image_alpha = floor(iframe/4) % 2;
} else if (iframe > 0) { 
	image_alpha = floor(iframe/2) % 2;
}

// Fell off stage
if (y > room_height+32) { event_user(4); }
