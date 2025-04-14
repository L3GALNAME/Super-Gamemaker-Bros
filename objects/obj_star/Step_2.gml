/// @description Application
if state { exit; }

// Application
var fall = syReal>-1;
sxReal = moveX(sxReal, obj_star);
syReal = moveY(syReal, fall, true, self);
if (syReal > fallCap) { syReal = fallCap; }
if (sxReal == 0) { sxReal = preSX * -1}

if ((y > room_height+16) or (x < obj_camera.x - 64)) { instance_destroy(); }