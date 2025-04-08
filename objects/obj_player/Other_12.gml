/// @description big -> fire
canMove = false;
action = "transform";
item = 1;
frame = 0;
animSpeed = 15/60;
obj_handler.objectVars = [];
obj_handler.objectVars = [action, "Fire", frame, animSpeed, x-obj_camera.x, y-8, dir];
obj_handler.paused = true;
global.time[2][0] = global.time[0][0];